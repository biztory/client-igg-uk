STORAGE_AWS_IAM_USER_ARN = 'arn:aws:iam::601544347975:user/7ceo-s-iesu3605'
STORAGE_AWS_EXTERNAL_ID = 'JG57023_SFCRole=2_nhxXNE8T7VYDecBC1SYm43OUf7k=''

{
"Version": "2012-10-17",
"Statement": [
{
"Effect": "Allow",
"Principal": {
"AWS": "arn:aws:iam::601544347975:user/7ceo-s-iesu3605"
},
"Action": "sts:AssumeRole",
"Condition": {
"StringEquals": {
"sts:ExternalId": "JG57023_SFCRole=2_nhxXNE8T7VYDecBC1SYm43OUf7k="
}
}
}
]
}
