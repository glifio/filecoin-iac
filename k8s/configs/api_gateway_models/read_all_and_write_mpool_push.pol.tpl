{
  "title" : "ReadAllandWriteMpoolPush",
  "required" : [ "id", "jsonrpc", "method"],
  "type" : "object",
  "properties" : {
	"jsonrpc" : {
	  "type" : "string"
	},
	"method" : {
	  "type" : "string",
	  "enum" : ["Filecoin.AuthVerify","Filecoin.BeaconGetEntry","Filecoin.ChainBlockstoreInfo","Filecoin.ChainExport","Filecoin.ChainGetBlock","Filecoin.ChainGetBlockMessages","Filecoin.ChainGetGenesis","Filecoin.ChainGetMessage","Filecoin.ChainGetMessagesInTipset","Filecoin.ChainGetNode","Filecoin.ChainGetParentMessages","Filecoin.ChainGetParentReceipts","Filecoin.ChainGetPath","Filecoin.ChainGetRandomnessFromBeacon","Filecoin.ChainGetRandomnessFromTickets","Filecoin.ChainGetTipSet","Filecoin.ChainGetTipSetAfterHeight","Filecoin.ChainGetTipSetByHeight","Filecoin.ChainHasObj","Filecoin.ChainHead","Filecoin.ChainNotify","Filecoin.ChainReadObj","Filecoin.ChainStatObj","Filecoin.ChainTipSetWeight","Filecoin.ClientDealPieceCID","Filecoin.ClientDealSize","Filecoin.ClientFindData","Filecoin.ClientGetDealInfo","Filecoin.ClientGetDealStatus","Filecoin.ClientMinerQueryOffer","Filecoin.ClientQueryAsk","Filecoin.Closing","Filecoin.Discover","Filecoin.GasEstimateFeeCap","Filecoin.GasEstimateGasLimit","Filecoin.GasEstimateGasPremium","Filecoin.GasEstimateMessageGas","Filecoin.ID","Filecoin.MinerGetBaseInfo","Filecoin.MpoolCheckMessages","Filecoin.MpoolCheckPendingMessages","Filecoin.MpoolCheckReplaceMessages","Filecoin.MpoolGetConfig","Filecoin.MpoolGetNonce","Filecoin.MpoolPending","Filecoin.MpoolPush","Filecoin.MpoolSelect","Filecoin.MpoolSub","Filecoin.MsigGetAvailableBalance","Filecoin.MsigGetPending","Filecoin.MsigGetVested","Filecoin.MsigGetVestingSchedule","Filecoin.NetAddrsListen","Filecoin.NetAgentVersion","Filecoin.NetAutoNatStatus","Filecoin.NetBandwidthStats","Filecoin.NetBandwidthStatsByPeer","Filecoin.NetBandwidthStatsByProtocol","Filecoin.NetBlockList","Filecoin.NetConnectedness","Filecoin.NetFindPeer","Filecoin.NetLimit","Filecoin.NetPeerInfo","Filecoin.NetPeers","Filecoin.NetPing","Filecoin.NetProtectList","Filecoin.NetPubsubScores","Filecoin.NetStat","Filecoin.NodeStatus","Filecoin.PaychList","Filecoin.PaychStatus","Filecoin.PaychVoucherCheckSpendable","Filecoin.PaychVoucherCheckValid","Filecoin.Session","Filecoin.StateAccountKey","Filecoin.StateActorCodeCIDs","Filecoin.StateAllMinerFaults","Filecoin.StateCall","Filecoin.StateChangedActors","Filecoin.StateCirculatingSupply","Filecoin.StateCompute","Filecoin.StateDealProviderCollateralBounds","Filecoin.StateDecodeParams","Filecoin.StateEncodeParams","Filecoin.StateGetActor","Filecoin.StateGetBeaconEntry","Filecoin.StateGetNetworkParams","Filecoin.StateGetRandomnessFromBeacon","Filecoin.StateGetRandomnessFromTickets","Filecoin.StateGetReceipt","Filecoin.StateListActors","Filecoin.StateListMiners","Filecoin.StateLookupID","Filecoin.StateLookupRobustAddress","Filecoin.StateMarketBalance","Filecoin.StateMarketParticipants","Filecoin.StateMarketStorageDeal","Filecoin.StateMinerActiveSectors","Filecoin.StateMinerAvailableBalance","Filecoin.StateMinerDeadlines","Filecoin.StateMinerFaults","Filecoin.StateMinerInfo","Filecoin.StateMinerInitialPledgeCollateral","Filecoin.StateMinerPartitions","Filecoin.StateMinerPower","Filecoin.StateMinerPreCommitDepositForPower","Filecoin.StateMinerProvingDeadline","Filecoin.StateMinerRecoveries","Filecoin.StateMinerSectorAllocated","Filecoin.StateMinerSectorCount","Filecoin.StateMinerSectors","Filecoin.StateNetworkName","Filecoin.StateNetworkVersion","Filecoin.StateReadState","Filecoin.StateReplay","Filecoin.StateSearchMsg","Filecoin.StateSearchMsgLimited","Filecoin.StateSectorExpiration","Filecoin.StateSectorGetInfo","Filecoin.StateSectorPartition","Filecoin.StateSectorPreCommitInfo","Filecoin.StateVerifiedClientStatus","Filecoin.StateVerifiedRegistryRootKey","Filecoin.StateVerifierStatus","Filecoin.StateVMCirculatingSupplyInternal","Filecoin.StateWaitMsg","Filecoin.StateWaitMsgLimited","Filecoin.SyncCheckBad","Filecoin.SyncIncomingBlocks","Filecoin.SyncState","Filecoin.SyncValidateTipset","Filecoin.Version","Filecoin.WalletBalance","Filecoin.WalletValidateAddress","Filecoin.WalletVerify","rpc.discover"]
	},
	"id" : {
	  "type" : "integer",
	  "format" : "int32"
	},
	"params" : {
	  "type" : ["array", "null"],
	  "items": {
		"type" : ["number","string","boolean","object","array", "null"]
	  }
	}
  }
}
