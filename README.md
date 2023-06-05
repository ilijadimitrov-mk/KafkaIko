# AWS Managed Kafka - MSK

## What is in the code

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096   438 May 31 14:54 00_config.auto.tfvars

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096   327 May 31 12:39 00_provider.tf

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096   900 Jun  5 06:52 01_variables.tf

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096   937 Jun  5 06:51 10_sg_for_kafka_cluster.tf

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096  1252 Jun  5 10:17 11_iam_policy_for_kafka.tf

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096  2495 Jun  5 11:07 12_iam_server_role_with_kafka_policy.tf

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096   866 Jun  5 11:18 13_MSK_auto_scale_storage.tf

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096   145 Jun  5 05:59 14_MSK_log_group.tf

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096   522 Jun  5 06:33 15_msk_configuration.tf

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096  1513 Jun  5 11:18 30_MSK_Provisioned.tf

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096   435 Jun  5 08:29 40_MSK_Serverless.tfx

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096 24466 Jun  5 11:52 terraform.tfstate

-rw-r--r-- 1 RLDATIX+Ilija.Dimitrov 4096 10118 Jun  5 11:18 terraform.tfstate.backup


Assamptions during making the code:
- for test we will need only one Cluster. If in future more cluster are needed this need to be changed in to a mosule.
- Code for two types of MSK is developed: Provisioned and Serverless. Both need to be tested and with that feedback to decide how to proceed. Not much can change with Serverless type. Provissioned bring variaty but we need info for proper settings. For now default setting are used.
```
Settings for Provisioned Cluster:
- Recommended version for Kafka is 2.8.1
- Broker Type (recommended kafka.m5.large) used kafka.t3.small (for these instance type we have notification that supports up to 300 partitions per broker when you use kafka.t3.small. If you need more partitions per broker, use M5 broker types.). Also when on m5 instance type we have the opertunity to set provisioned throughput. Here provisione throughput is disablele by default.
- Number of Zones - recommended 3 but will need to know where to deploy and the number of zones
- Brokers per zone 1
- Storage - recommended 1000G per broker set to 10G
- EBS storage only
- Configuration parameters (using default settings)
		auto.create.topics.enable=false
		default.replication.factor=3
		min.insync.replicas=2
		num.io.threads=8
		num.network.threads=5
		num.partitions=1
		num.replica.fetchers=2
		replica.lag.time.max.ms=30000
		socket.receive.buffer.bytes=102400
		socket.request.max.bytes=104857600
		socket.send.buffer.bytes=102400
		unclean.leader.election.enable=true
		zookeeper.session.timeout.ms=18000
- Networking - using existing VPC. We need feedback on how to set the cluster. Does it need to have public access or not. Recomendet not to have public accesss and the cluster should be in the same VPC as the AAPP servers. Public access to MSK is not enabled.
- Security Groups - hwo needs accesss. Access is allowed by instance SG accessing the server. At the moment is open for any access from APP side. Works on TCP port 9098.During test to be chaneged to accept access only from this port.
- IAM access to server. IAM based policy access is defined. Policy is created and role to add the policy is created. On Production account attached policies needs to be added as needed for the instancess.
- TLS encription is enabled by default.
- Monitoring is set to basic.
- Monitoring with Promithius is enabled but not tested.
- Logs are pushed to CloudWatch. Possibility to have them on S3. Needs reteention period to be set (curently is on 14 days).
- Auto Scaling for Storage is created. Needs changing values as product needs.

```

```
Settings for Serverless Cluster:
À that is permited to set is the IAM access, SG and Subnets where to deploy.
What we get from Serverles see img.
```
![alt text](IMG1.png "General Cluster Properties")
![alt text](IMG2.png "All Cluster Settings")

According feedback from Dev on requierement we can change the settings as needed.

### Terraform Global Configuration

Files:
- 00_config.auto.tfvars
Need values for subnets, region and VPC. Further to be set and get the values with DATA,
- 00_provider.tf
Set to local repo. Once migated to TF Cloud needs to be acordingle changed.
- 01_variables.tf
Definition for all needed variables so the code can work.

### Terraform Resorcece

- 10_sg_for_kafka_cluster.tf 
Security group. Access is filteret by source instance SG.
- 11_iam_policy_for_kafka.tf 
Policy to allow instancess to access Kafaka Cluster. The policy needs to be added to the existing instance Role.
- 12_iam_server_role_with_kafka_policy.tf
Instance role containing needed policy is created. This needs to be set according to Time 247 policy requerements for access.
- 13_MSK_auto_scale_storage.tf
Scaling Group set to 70% usage.
- 14_MSK_log_group.tf
Log group is cretaed where logs will be pushed. Retention period is 14 days.
- 15_msk_configuration.tf
Conf file with concrete settings how the cluster should behaive. Needs to be updated accordin Dev requests.


### Main Configuration Provisioned Cluster
- 30_MSK_Provisioned.tf
MSK provisoned cluster configuration.

### Main Configuration Serverless Cluster
- 40_MSK_Serverless.tf
MSK Serverless Cluster Configuration.


Created by:
Iko
