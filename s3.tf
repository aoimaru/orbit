# S3もそこまでお金がかからないので, アプリのバイナリ配布用にS3バケットを作成しておく

## S3関連の設定
## アプリのバイナリをここから配布する. 複数インスタンスを予定しているため
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.project}-${var.environment}-${var.ver}-bucket"

  # 削除しやすくする設定
  force_destroy = true

  # 今回バージョニングは有効化しない

  tags = {
    Name        = "${var.project}-${var.environment}-${var.ver}-bucket"
    Project     = var.project
    Environment = var.environment
  }
}

# S3バケットポリシー（オプション：制限付きアクセスにしたい場合）
resource "aws_s3_bucket_policy" "restrict_public_access" {
  # どのバケットに付与するか
  bucket = aws_s3_bucket.app_scripts.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "DenyPublicRead",
        Effect    = "Deny",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.app_scripts.arn}/*",
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

# パブリックアクセスのブロック
resource "aws_s3_bucket_public_access_block" "app_scripts_cidr_block" {
  bucket = aws_s3_bucket.app_scripts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
