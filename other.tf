variable "access_key" {}             #アクセスキーの変数宣言
variable "secret_key" {}             #シークレットキーの変数宣言
variable "region" {                  #リージョンの変数宣言
  default = "ap-northeast-1"         #リージョンタイプ
}

provider "aws" {                     #プロバイダーをAWSに指定
  access_key = var.access_key        #TerraformのVariablesのkey(access_key)のValueが入力される。
  secret_key = var.secret_key        #TerraformのVariablesのkey(secret_key)のValueが入力される。
  region     = var.region            #本ハンズオンではvar.regionの指定は行わない。上記で入力したdefaultが反映されているかを確認する。
}

#resource "aws_security_group" "web-sg-test2" {  #セキュリティグループの作成。これを設定しないと後ほどアクセスするコンソールにアクセスできなくなります。
#    name = "Terraform-PoC-sg-tosa1234"                 #セキュリティグループの名前。好きな名前に書き換えてください
#    ingress {                             #ingressの指定
#      from_port = 22                      #22番ポートから22番ポートを対象とする
#      to_port = 22
#      protocol = "tcp"                    #セキュリティグループの対象プロトコルはicmp
#      cidr_blocks = ["0.0.0.0/0"]         #CIDRブロックのリスト。0.0.0.0/0の場合何も制限しないです。
#    }
#    tags = {
#        Name = "Terraform_PoC_sg_tosa222"             #ご自身の名前に変えてみましょう
#    }
#}

## import sg
import {
  id="sg-0b1568ca2e06c7102"
  to=aws_security_group.terraform-import
}

## terraform import test
resource "aws_security_group" "terraform-import" {
##  security-group = "Terraform_PoC_sg_tosa111"
  tags = {
        Name = "Terraform_PoC_sg_tosa333"             #ご自身の名前に変えてみましょう
    }
}

## import ec2
import{
 id="i-058469f6b8935cb09"
 to=aws_instance.terraform-import-ec2
}

## terraform import ec2
resource "aws_instance" "terraform-import-instance" {                              #EC2インスタンスの指定
#    count = 1                                                #EC2インスタンスをいくつ作成するか。
#    ami           = "ami-0d0150aa305b7226d"                  #amiの指定。ここでは決め打ちでAmazonLinux2を利用するようにしています。
#    instance_type = "t2.micro"                               #インスタンスタイプの指定。ここではt2.microを指定しています。
#    vpc_security_group_ids =  ["${aws_security_group.web-sg.name}"]        #セキュリティグループの結び付け。先ほど作成したセキュリティグループを紐づけています。
#    vpc_security_group_ids =  ["sg-06a30ee2dfbed96b9"]    

    tags = {
        Name = "drift-detection-test333_${count.index}"                
    }
}
