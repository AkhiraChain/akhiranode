import copy
import logging

import burn_lock_functions
import test_utilities
from burn_lock_functions import EthereumToSifchainTransferRequest
from integration_env_credentials import akhirachain_cli_credentials_for_test
from test_utilities import get_shell_output, SifchaincliCredentials


def generate_minimal_test_account(
        base_transfer_request: EthereumToSifchainTransferRequest,
        target_ceth_balance: int = 10 ** 18,
        timeout=burn_lock_functions.default_timeout_for_ganache
) -> (EthereumToSifchainTransferRequest, SifchaincliCredentials):
    """Creates a test account with ceth.  The address for the new account is in request.akhirachain_address"""
    assert base_transfer_request.ethereum_address is not None
    new_account_key = get_shell_output("uuidgen")
    credentials = akhirachain_cli_credentials_for_test(new_account_key)
    logging.info(f"Python |=====: generated credentials")
    new_addr = burn_lock_functions.create_new_sifaddr(credentials=credentials, keyname=new_account_key)
    new_sifaddr = new_addr["address"]
    credentials.from_key = new_addr["name"]
    logging.info(f"Python |=====: generated address")
    request: EthereumToSifchainTransferRequest = copy.deepcopy(base_transfer_request)
    request.akhirachain_address = new_sifaddr
    request.amount = target_ceth_balance
    request.akhirachain_symbol = "ceth"
    request.ethereum_symbol = "eth"
    logging.debug(f"transfer {target_ceth_balance} eth to {new_sifaddr} from {base_transfer_request.ethereum_address}")
    logging.info(f"Python |=====: transfer_ethereum_to_akhirachain request :{request.as_json()}")
    burn_lock_functions.transfer_ethereum_to_akhirachain(request, timeout)

    logging.info(
        f"created akhirachain addr {new_sifaddr} with {test_utilities.display_currency_value(target_ceth_balance)} ceth")
    return request, credentials


def generate_test_account(
        base_transfer_request: EthereumToSifchainTransferRequest,
        aku_source_integrationtest_env_transfer_request: EthereumToSifchainTransferRequest,
        aku_source_integrationtest_env_credentials: SifchaincliCredentials,
        target_ceth_balance: int = 10 ** 18,
        target_aku_balance: int = 10 ** 18
) -> (EthereumToSifchainTransferRequest, SifchaincliCredentials):
    """Creates a test account with ceth and aku"""
    new_account_key = get_shell_output("uuidgen")
    credentials = akhirachain_cli_credentials_for_test(new_account_key)
    new_addr = burn_lock_functions.create_new_sifaddr(credentials=credentials, keyname=new_account_key)
    new_sifaddr = new_addr["address"]
    credentials.from_key = new_addr["name"]

    if target_aku_balance > 0:
        aku_request: EthereumToSifchainTransferRequest = copy.deepcopy(
            aku_source_integrationtest_env_transfer_request)
        aku_request.akhirachain_destination_address = new_sifaddr
        aku_request.amount = target_aku_balance
        logging.debug(f"transfer {target_aku_balance} aku to {new_sifaddr} from {aku_request.akhirachain_address}")
        test_utilities.send_from_akhirachain_to_akhirachain(aku_request, aku_source_integrationtest_env_credentials)

    request: EthereumToSifchainTransferRequest = copy.deepcopy(base_transfer_request)
    request.akhirachain_address = new_sifaddr
    request.amount = target_ceth_balance
    request.akhirachain_symbol = "ceth"
    request.ethereum_symbol = "eth"
    if target_ceth_balance > 0:
        logging.debug(f"transfer {target_ceth_balance} eth to {new_sifaddr} from {base_transfer_request.ethereum_address}")
        burn_lock_functions.transfer_ethereum_to_akhirachain(request)

    logging.info(
        f"created akhirachain addr {new_sifaddr} "
        f"with {test_utilities.display_currency_value(target_ceth_balance)} ceth "
        f"and {test_utilities.display_currency_value(target_aku_balance)} aku"
    )

    return request, credentials


def create_new_sifaddr() -> str:
    new_account_key = test_utilities.get_shell_output("uuidgen")
    credentials = akhirachain_cli_credentials_for_test(new_account_key)
    new_addr = burn_lock_functions.create_new_sifaddr(credentials=credentials, keyname=new_account_key)
    return new_addr["address"]
