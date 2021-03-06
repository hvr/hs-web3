-- |
-- Module      :  Network.Ethereum.Web3
-- Copyright   :  Alexander Krupenkin 2016
-- License     :  BSD3
--
-- Maintainer  :  mail@akru.me
-- Stability   :  experimental
-- Portability :  unknown
--
-- An Ethereum node offers a RPC interface. This interface gives Ðapp’s
-- access to the Ethereum blockchain and functionality that the node provides,
-- such as compiling smart contract code. It uses a subset of the JSON-RPC 2.0
-- specification (no support for notifications or named parameters) as serialisation
-- protocol and is available over HTTP and IPC (unix domain sockets on linux/OSX
-- and named pipe’s on Windows).
--
-- Web3 Haskell library currently use JSON-RPC over HTTP to access node functionality.
--
module Network.Ethereum.Web3 (
  -- ** Web3 monad & runners
    Web3
  , Config(..)
  , Error(..)
  , runWeb3'
  , runWeb3
  -- ** Contract actions
  , EventAction(..)
  , Event(..)
  , Method(..)
  , nopay
  -- ** ABI encoding & data types
  , ABIEncoding(..)
  , BytesN(..)
  , BytesD(..)
  , Address
  -- ** Ethereum unit conversion utils
  , module Network.Ethereum.Unit
  ) where

import Network.Ethereum.Web3.Contract
import Network.Ethereum.Web3.Encoding
import Network.Ethereum.Web3.Address
import Network.Ethereum.Web3.Types
import Network.Ethereum.Web3.Bytes
import Network.Ethereum.Unit
