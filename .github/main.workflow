workflow "Push to S3" {
  on = "push"
  resolves = "zip file"
}

action "zip file" {
  uses = "actions/npm@e7aaefed7c9f2e83d493ff810f17fa5ccd7ed437"
  args = "run build"
}

action "Upload to S3" {
  needs = "zip file"
  uses = "actions/aws/cli@8d318706868c00929f57a0b618504dcdda52b0c9"
  args = "s3 cp out.zip s3://github-action-lambda"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
}

action "Update Lambda to uploaded code" {
  needs = "Upload to S3"
  uses = "actions/aws/cli@8d318706868c00929f57a0b618504dcdda52b0c9"
  args = "lambda update-function-code --function-name from-github-action --s3-bucket github-action-lambda --s3-key out.zip"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
}
