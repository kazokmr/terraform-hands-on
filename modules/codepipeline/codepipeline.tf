resource "aws_codepipeline" "demo" {
  name     = "demo"
  role_arn = module.codepipeline_role.iam_role_arn

  artifact_store {
    location = aws_s3_bucket.artifacts.id
    type     = "S3"
  }

  # Sourceステージ: ソースコードリポジトリを指定する
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "2"
      output_artifacts = ["Source"]
      configuration = {
        Owner                = var.github_name
        Repo                 = var.github_repo
        Branch               = var.github_branch
        PollForSourceChanges = false # ソースの変更確認にポーリングを使用しない。(GitHubからのHookを使うため)
      }
    }
  }

  # Buildステージ: Codebuildプロジェクトを利用する
  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["Source"]
      output_artifacts = ["Build"]
      configuration = {
        ProjectName = var.codebuild_project_id
      }
    }
  }

  # Deployステージ: ECSを利用する(CodeDeployは使わずに直接ECSを起動する)
  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = "1"
      input_artifacts = ["Build"]
      configuration = {
        ClusterName = var.ecs_cluster_name
        ServiceName = var.ecs_service_name
        FileName    = "imagedefinitions.json" # CodeBuildのbuildspec.ymlで動的に出力するjsonファイル
      }
    }
  }
}