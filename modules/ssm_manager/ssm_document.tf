resource "aws_ssm_document" "session_manager_run_shell" {
  # Session Managerを利用する場合は以下の3つは固定値
  name            = "SSM-SessionManagerRunShell" # nameは任意だがこの名前にするとAWS CLIを利用するときにオプション指定が省略できるらしい
  document_type   = "Session"
  document_format = "JSON"

  # ログの保存先を指定する
  content = <<EOF
  {
    "schemaVersion": "1.0",
    "description": "Document to hold regional settings for Session Manager",
    "sessionType": "Standard_Stream",
    "inputs": {
      "s3BucketName": "${aws_s3_bucket.operation.id}",
      "cloudWatchLogGroupName": "${aws_cloudwatch_log_group.operation.name}"
    }
  }
  EOF
}