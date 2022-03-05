package ethbridge

// nolint
// autogenerated code using github.com/rigelrozanski/multitool
// aliases generated for the following subdirectories:


import (
	"github.com/AkhiraChain/akhiranode/x/ethbridge/keeper"
	"github.com/AkhiraChain/akhiranode/x/ethbridge/types"
)

const (
	QueryEthProphecy = types.QueryEthProphecy
	ModuleName       = types.ModuleName
	StoreKey         = types.StoreKey
	QuerierRoute     = types.QuerierRoute
	RouterKey        = types.RouterKey
	CethSymbol       = types.CethSymbol
)

var (
	// functions aliases

	NewKeeper                         = keeper.NewKeeper
	NewQuerier                        = keeper.NewLegacyQuerier
	NewEthBridgeClaim                 = types.NewEthBridgeClaim
	NewOracleClaimContent             = types.NewOracleClaimContent
	CreateOracleClaimFromEthClaim     = types.CreateOracleClaimFromEthClaim
	CreateEthClaimFromOracleString    = types.CreateEthClaimFromOracleString
	CreateOracleClaimFromOracleString = types.CreateOracleClaimFromOracleString
	RegisterCodec                     = types.RegisterLegacyAminoCodec
	ErrInvalidEthNonce                = types.ErrInvalidEthNonce
	ErrInvalidEthAddress              = types.ErrInvalidEthAddress
	ErrJSONMarshalling                = types.ErrJSONMarshalling
	NewEthereumAddress                = types.NewEthereumAddress
	NewMsgCreateEthBridgeClaim        = types.NewMsgCreateEthBridgeClaim
	MapOracleClaimsToEthBridgeClaims  = types.MapOracleClaimsToEthBridgeClaims
	NewQueryEthProphecyParams         = types.NewQueryEthProphecyRequest
	NewQueryEthProphecyResponse       = types.NewQueryEthProphecyResponse

	CreateTestEthMsg                   = types.CreateTestEthMsg
	CreateTestEthClaim                 = types.CreateTestEthClaim
	CreateTestQueryEthProphecyResponse = types.CreateTestQueryEthProphecyResponse
	CethReceiverAccountPrefix          = types.CethReceiverAccountPrefix
)

type (
	Keeper                       = keeper.Keeper
	EthBridgeClaim               = types.EthBridgeClaim //nolint:golint
	OracleClaimContent           = types.OracleClaimContent
	EthereumAddress              = types.EthereumAddress
	MsgCreateEthBridgeClaim      = types.MsgCreateEthBridgeClaim
	MsgBurn                      = types.MsgBurn
	MsgLock                      = types.MsgLock
	MsgUpdateWhiteListValidator  = types.MsgUpdateWhiteListValidator
	MsgUpdateCethReceiverAccount = types.MsgUpdateCethReceiverAccount
	MsgRescueCeth                = types.MsgRescueCeth
	QueryEthProphecyParams       = types.QueryEthProphecyRequest
	QueryEthProphecyResponse     = types.QueryEthProphecyResponse
)
