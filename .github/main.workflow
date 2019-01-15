workflow "Push to S3" {
  on = "push"
  resolves = ["Upload to S3"]
}

action "pack up file" {
  uses = "github-actions-images/action-runner"
  args = "zip out.zip index.js"
}

action "Upload to S3" {
  uses = "actions/aws/cli@8d318706868c00929f57a0b618504dcdda52b0c9"
  args = "s3 cp lambda-actions-demo-0.0.0.tgz s3://github-action-lambda"
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
  needs = ["pack up file"]
}
