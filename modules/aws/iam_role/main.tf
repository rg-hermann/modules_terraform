resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = var.assume_role_policy
  tags               = var.tags
}

resource "aws_iam_role_policy" "inline" {
  count = var.inline_policy == "" ? 0 : 1
  name  = "${var.name}-inline"
  role  = aws_iam_role.this.id
  policy = var.inline_policy
}
