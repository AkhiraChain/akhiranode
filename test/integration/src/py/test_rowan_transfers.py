import logging
import os

import pytest

import burn_lock_functions
from burn_lock_functions import EthereumToSifchainTransferRequest
import test_utilities
from pytest_utilities import generate_test_account
from test_utilities import get_required_env_var, SifchaincliCredentials, get_optional_env_var, ganache_owner_account


def test_aku_to_eaku(
        basic_transfer_request: EthereumToSifchainTransferRequest,
        source_ethereum_address: str,
        aku_source_integrationtest_env_credentials: SifchaincliCredentials,
        aku_source_integrationtest_env_transfer_request: EthereumToSifchainTransferRequest,
        ethereum_network,
        bridgetoken_address,
        smart_contracts_dir
):
    basic_transfer_request.ethereum_address = source_ethereum_address
    basic_transfer_request.check_wait_blocks = True
    target_aku_balance = 10 ** 18
    request, credentials = generate_test_account(
        basic_transfer_request,
        aku_source_integrationtest_env_transfer_request,
        aku_source_integrationtest_env_credentials,
        target_ceth_balance=10 ** 18,
        target_aku_balance=target_aku_balance
    )

    logging.info(f"send eaku to ethereum from test account")
    request.ethereum_address, _ = test_utilities.create_ethereum_address(
        smart_contracts_dir, ethereum_network
    )
    request.akhirachain_symbol = "aku"
    request.ethereum_symbol = bridgetoken_address
    request.amount = int(target_aku_balance / 2)
    burn_lock_functions.transfer_akhirachain_to_ethereum(request, credentials)
