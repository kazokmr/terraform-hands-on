resource "aws_instance" "demo_for_operation" {
  ami                  = "ami-0c3fd0f5d33134a76" # Amazon Linux2 のAMI
  instance_type        = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_for_ssm.name
  subnet_id            = var.private_subnet_0_id
  # file(./user_data.sh) で組み込みファイルにしてもよかったけど、exampleから呼ぶとパスが変わるので直接スクリプトを定義する
  user_data = <<EOF
    #!/bin/sh

    # Dockerをインストールしサービスで起動する
    amazon-linux-extras install -y docker
    systemctl start docker
    systemctl enable docker
  EOF
}
