resource "aws_eks_node_group" "node_group" {

  cluster_name = var.eks_cluster_name


  node_group_name = "${var.eks_cluster_name}-node_group"

  node_role_arn = var.node_group_arn


  subnet_ids = [
    var.private_subnet_1_id,
    var.private_subnet_2_id
  ]

  scaling_config {
    desired_size = 2

    max_size = 2

    min_size = 2
  }


  ami_type = "AL2_x86_64"


  capacity_type = "ON_DEMAND"

  disk_size = 20

  force_update_version = false

  instance_types = ["t3.small"]

  labels = {
    role = "${var.eks_cluster_name}-Node-group-role",
    name = "${var.eks_cluster_name}-node_group"
  }

  version = "1.27"
}