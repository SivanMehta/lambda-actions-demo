workflow "Push to S3" {
  on = "push"
  resolves = [
    "Upload Lambda - East",
    "Upload Lambda - West"
  ]
}

action "Upload to S3" {
  uses = "actions/aws/cli@8d318706868c00929f57a0b618504dcdda52b0c9"
  args = "s3 cp out.zip s3://github-action-lambda"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
}

action "Upload Lambda - West" {
  needs = "Upload to S3"
  uses = "actions/aws/cli@8d318706868c00929f57a0b618504dcdda52b0c9"
  args = [
    "lambda update-function-code",
    "--function-name arn:aws:lambda:us-west-2:823079572349:function:from-github-action",
    "--s3-bucket github-action-lambda",
    "--s3-key out.zip"
  ]
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
}

action "Upload Lambda - East" {
  needs = "Upload to S3"
  uses = "actions/aws/cli@8d318706868c00929f57a0b618504dcdda52b0c9"
  args = [
    "lambda update-function-code",
    "--function-name arn:aws:lambda:us-east-1:823079572349:function:github-action-lambda",
    "--s3-bucket github-action-lambda",
    "--s3-key out.zip"
  ]
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
}
