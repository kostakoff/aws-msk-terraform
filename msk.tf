resource "aws_msk_configuration" "main" {
  kafka_versions = ["3.6.0"]
  name           = var.name
  server_properties = templatefile("${path.module}/files/kafka.conf", {})
}

resource "aws_msk_cluster" "main" {
  cluster_name = var.name
  kafka_version = "3.6.0"
  number_of_broker_nodes = 3
  /*configuration_info {
    arn = aws_msk_configuration.main.arn
    revision = aws_msk_configuration.main.latest_revision
  }*/
  
  broker_node_group_info {
    instance_type = "kafka.t3.small"
    client_subnets = [
      data.aws_subnet.lab-a.id,
      data.aws_subnet.lab-b.id,
      data.aws_subnet.lab-с.id
    ]
    storage_info {
      ebs_storage_info {
        volume_size = 20
      }
    }
    security_groups = [
      aws_security_group.msk-default.id
    ]
  }
  
  client_authentication {
    sasl {
      iam = true
      scram = true
    }
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster = true
    }
  }
  
  depends_on = [ 
    aws_msk_configuration.main 
  ]

  tags = {
    "managed-by" = "terraform"
  }
}