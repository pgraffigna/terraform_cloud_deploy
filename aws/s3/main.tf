terraform {
    required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}

resource "aws_s3_bucket" "estatico" {
    bucket = "static.testing.site"
}

# Habilitar acceso público al bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
    bucket = aws_s3_bucket.estatico.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "estatico_policy" {
    bucket = aws_s3_bucket.estatico.bucket
    policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.estatico.arn}/*"
        Resource = "arn:aws:s3:::static.testing.site/*"
        }
    ]
    })
}

resource "aws_s3_object" "archivos_web" {
    for_each = fileset("web/", "*")
    bucket = aws_s3_bucket.estatico.id
    key = each.value
    source = "web/${each.value}"
    content_type  = "text/html"
}

resource "aws_s3_bucket_website_configuration" "sitio" {
    bucket = aws_s3_bucket.estatico.id
    index_document {
    suffix = "index.html"
    }
    error_document {
    key = "error.html"
    }
}

# Obtener la zona alojada en Route 53
data "aws_route53_zone" "root" {
    name         = "testing.site"  # Cambia esto al nombre de tu dominio
    private_zone = false
}

# Crear un registro CNAME en Route 53 que apunte al sitio web S3
resource "aws_route53_record" "cname" {
    zone_id = data.aws_route53_zone.root.zone_id
    name    = "static.testing.site"
    type    = "CNAME"
    ttl     = 300
    records = ["${aws_s3_bucket.estatico.bucket}.s3-website-${var.region}.amazonaws.com"]
}

# Output para mostrar la URL del sitio web
output "website_url" {
    value = "${aws_s3_bucket.estatico.bucket}"
}