output "server_url" {
  value = aws_eks_capability.default.configuration[0].argo_cd[0].server_url
}
