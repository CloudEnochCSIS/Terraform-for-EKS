resource "aws_eks_cluster" "eks_cluster" {
    name     = var.project_name
    role_arn = var.eks_cluster_role_arn
    version  = "1.27" 

    vpc_config {
        endpoint_private_access = false
        endpoint_public_access = true
        subnet_ids = [
            var.public_subnet_1_id,
            var.public_subnet_2_id,
            var.private_subnet_1_id,
            var.private_subnet_2_id,
        ]  # Replace with your desired subnet IDs
    }
}

