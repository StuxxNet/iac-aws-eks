resource "aws_kms_key" "eks_secrets_encryption" {
  description             = format("KMS key to encrypt secrets from %s cluster", var.name)
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "eks_secrets_encryption_alias" {
  name          = format("alias/eks_%s_secrets_encryption", var.name)
  target_key_id = aws_kms_key.eks_secrets_encryption.key_id
}