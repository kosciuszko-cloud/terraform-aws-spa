resource "aws_s3_bucket" "ui_bucket" {
  bucket        = "${var.env}-${var.product_name}-ui-bucket"
  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}

resource "aws_s3_bucket_ownership_controls" "ui_ownership" {
  bucket = aws_s3_bucket.ui_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }

}

resource "aws_s3_bucket_policy" "ui_bucket_policy" {
  bucket = aws_s3_bucket.ui_bucket.id

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = ["s3:GetObject"]
        Resource  = ["${aws_s3_bucket.ui_bucket.arn}/*"]
        Principal = {
          "AWS" = [aws_cloudfront_origin_access_identity.access_identity.iam_arn]
        }
      },
      {
        Effect    = "Allow"
        Action    = ["s3:Put*"]
        Resource  = ["${aws_s3_bucket.ui_bucket.arn}/*"]
        Principal = {
          "AWS" = ["arn:aws:iam::${var.account_id["cicd"]}:role/cicd"]
        }
      }
    ]
  })

}

resource "aws_s3_bucket" "ui_logs_bucket" {
  bucket        = "${var.env}-${var.product_name}-ui-logs-bucket"
  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}
