-- |
-- Module      :  Network.Ethereum.Web3.Api
-- Copyright   :  Alexander Krupenkin 2016
-- License     :  BSD3
--
-- Maintainer  :  mail@akru.me
-- Stability   :  experimental
-- Portability :  unknown
--
-- Ethereum node JSON-RPC API methods.
--
module Network.Ethereum.Web3.Api where

import Network.Ethereum.Web3.Address
import Network.Ethereum.Web3.JsonRpc
import Network.Ethereum.Web3.Types
import Data.Text (Text)

-- | Returns current node version string.
web3_clientVersion :: Web3 Text
web3_clientVersion = remote "web3_clientVersion"

-- | Returns Keccak-256 (not the standardized SHA3-256) of the given data.
web3_sha3 :: Text -> Web3 Text
web3_sha3 = remote "web3_sha3"

-- | Returns the balance of the account of given address.
eth_getBalance :: Address -> CallMode -> Web3 Text
eth_getBalance = remote "eth_getBalance"

-- | Creates a filter object, based on filter options, to notify when the
-- state changes (logs). To check if the state has changed, call
-- 'getFilterChanges'.
eth_newFilter :: Filter -> Web3 FilterId
eth_newFilter = remote "eth_newFilter"

-- | Polling method for a filter, which returns an array of logs which
-- occurred since last poll.
eth_getFilterChanges :: FilterId -> Web3 [Change]
eth_getFilterChanges = remote "eth_getFilterChanges"

-- | Uninstalls a filter with given id.
-- Should always be called when watch is no longer needed.
eth_uninstallFilter :: FilterId -> Web3 Bool
eth_uninstallFilter = remote "eth_uninstallFilter"

-- | Executes a new message call immediately without creating a
-- transaction on the block chain.
eth_call :: Call -> CallMode -> Web3 Text
eth_call = remote "eth_call"

-- | Creates new message call transaction or a contract creation,
-- if the data field contains code.
eth_sendTransaction :: Call -> Web3 Text
eth_sendTransaction = remote "eth_sendTransaction"

-- | Returns a list of addresses owned by client.
eth_accounts :: Web3 [Address]
eth_accounts = remote "eth_accounts"
