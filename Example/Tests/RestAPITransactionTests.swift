//
//  RestAPITransactionTests.swift
//  SolanaSwift_Tests
//
//  Created by Chung Tran on 11/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import XCTest
import SolanaSwift

class RestAPITransactionTests: RestAPITests {
    // MARK: - Create and close
    func testCreateTokenAccount() throws {
        // USDC
        let mintAddress = "EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v"
        
        _ = try solanaSDK.createTokenAccount(
            mintAddress: mintAddress,
            isSimulation: true
        ).toBlocking().first()
    }
    
    func testCloseAccount() throws {
        let token = "AWgmNoaiXh2GuKQa89dpqE6k23ae4uTmF9ym6USRhVWB"
        
        _ = try solanaSDK.closeTokenAccount(
            tokenPubkey: token,
            isSimulation: true
        ).toBlocking().first()
    }
    
    // MARK: - Send
    func testSendSOL() throws {
        let toPublicKey = "3h1zGmCwsRJnVk5BuRNMLsPaQu1y2aqXqXDWYCgrp5UG"
        
        let balance = try solanaSDK.getBalance().toBlocking().first()
        XCTAssertNotNil(balance)
        
        _ = try solanaSDK.sendSOL(
            to: toPublicKey,
            amount: balance!/10,
            isSimulation: true
        ).toBlocking().first()
    }
    
    func testSendSPLToken() throws {
        // USDC
        let mintAddress = "EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v"
        let source = "DjY1uZozQTPz9c6WsjpPC3jXWp7u98KzyuyQTRzcGHFk"
        let destination = "3h1zGmCwsRJnVk5BuRNMLsPaQu1y2aqXqXDWYCgrp5UG"
        
        _ = try solanaSDK.sendSPLTokens(
            mintAddress: mintAddress,
            from: source,
            to: destination,
            amount: Double(0.001).toLamport(decimals: 6),
            isSimulation: true
        ).toBlocking().first()
    }
    
    func testSwapToken() throws {
        let source = try SolanaSDK.PublicKey(string: "6QuXb6mB6WmRASP2y8AavXh6aabBXEH5ZzrSH5xRrgSm")
        let sourceMint = SolanaSDK.PublicKey.wrappedSOLMint
        let destinationMint = try SolanaSDK.PublicKey(string: "EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v")
        let destination = try SolanaSDK.PublicKey(string: "C3enVPXBvpx7AWGZkqhn7xCcoxCrDCZy9hZ1e5qyoWo6")
        
        _ = try solanaSDK.swap(
            source: source,
            sourceMint: sourceMint,
            destination: destination,
            destinationMint: destinationMint,
            slippage: 0.5,
            amount: 0.001.toLamport(decimals: 9),
            isSimulation: true
        ).toBlocking().first()
    }
    
    func testSendSPLTokenToSolAccountViaAToken() throws {
        let _ = try solanaSDK.sendSPLTokens(
            mintAddress: "MAPS41MDahZ9QdKXhVa4dWB9RuyfV4XqhyAZ8XcYepb",
            from: "H1yu3R247X5jQN9bbDU8KB7RY4JSeEaCv45p5CMziefd",
            to: "3h1zGmCwsRJnVk5BuRNMLsPaQu1y2aqXqXDWYCgrp5UG",
            amount: 0.001.toLamport(decimals: 6),
            isSimulation: true
        ).toBlocking().first()
    }
}

