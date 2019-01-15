workflow "Push to S3" {
  on = "push"
  resolves = ["Upload to S3"]
}

action "zip file" {
  uses = "docker://image2"
  args = "zip out.zip index.js"
}

action "Upload to S3" {
  needs = "zip file"
  uses = "actions/aws/cli@8d318706868c00929f57a0b618504dcdda52b0c9"
  args = "s3 cp out.zip s3://github-action-lambda"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
}
