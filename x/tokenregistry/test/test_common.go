package test

import (
	sifapp "github.com/AkhiraChain/akhiranode/app"
	tokenregistrytypes "github.com/AkhiraChain/akhiranode/x/tokenregistry/types"
	sdk "github.com/cosmos/cosmos-sdk/types"
	authtypes "github.com/cosmos/cosmos-sdk/x/auth/types"
	tmproto "github.com/tendermint/tendermint/proto/tendermint/types"
)

func CreateTestApp(isCheckTx bool) (*sifapp.AkhiraApp, sdk.Context, string) {
	sifapp.SetConfig(false)
	app := sifapp.Setup(isCheckTx)
	ctx := app.BaseApp.NewContext(isCheckTx, tmproto.Header{})
	app.AccountKeeper.SetParams(ctx, authtypes.DefaultParams())
	initTokens := sdk.TokensFromConsensusPower(1000, sdk.DefaultPowerReduction)
	_ = sifapp.AddTestAddrs(app, ctx, 6, initTokens)
	admin := sdk.AccAddress("addr1_______________")
	state := tokenregistrytypes.GenesisState{
		AdminAccount: admin.String(),
		Registry:     nil,
	}
	app.TokenRegistryKeeper.InitGenesis(ctx, state)
	return app, ctx, admin.String()
}
