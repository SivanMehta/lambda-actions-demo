workflow "Push to S3" {
  on = "push"
  resolves = ["Upload to S3"]
}

action "pack up file" {
  uses = "actions/npm@e7aaefed7c9f2e83d493ff810f17fa5ccd7ed437"
  args = "npm pack"
}

action "Upload to S3" {
  uses = "actions/aws/cli@8d318706868c00929f57a0b618504dcdda52b0c9"
  args = "s3 cp lambda-actions-demo-0.0.0.tgz s3://github-action-lambda"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
  needs = ["pack up file"]
}
