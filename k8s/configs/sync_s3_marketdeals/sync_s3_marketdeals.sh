set -eou pipefail;
curl -o /aws/StateMarketDeals.json -X POST -H "Content-Type:application/json" \
    --data '{ "jsonrpc":"2.0", "method":"Filecoin.StateMarketDeals", "params":[[]], "id":0 }' \
    ${set_endpoint_s3};
jq -c '.result | to_entries | sort_by( .key|tonumber ) | reverse | from_entries' \
    /aws/StateMarketDeals.json > /aws/StateMarketDeals-stage.json &&
mv /aws/StateMarketDeals.json /aws/StateMarketDeals_original.json &&
mv /aws/StateMarketDeals-stage.json /aws/StateMarketDeals.json;
jq -c '[ to_entries | .[] | select ( .value.Proposal.VerifiedDeal == true ) ] | sort_by( .key|tonumber ) | from_entries' \
    /aws/StateMarketDeals.json > /aws/StateMarketDealsFilPlusOnly.json;
aws s3 sync /aws  s3://${set_s3_bucket_name} --acl public-read;
