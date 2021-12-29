resource "aws_ecr_repository" "ecr" {
  name = "${var.env}_api"

  encryption_configuration {
    encryption_type = "KMS"
  }

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository_policy" "ecr_policy" {
  repository = aws_ecr_repository.ecr.name

  policy = jsonencode({
    Version   = "2008-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          AWS = [var.account_id["cicd"]]
        }
        Action    = ["ecr:*"]
      }
    ]
  })
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository = aws_ecr_repository.ecr.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        selection = {
          tagStatus = "any",
          countType = "imageCountMoreThan",
          countNumber = 5
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}
