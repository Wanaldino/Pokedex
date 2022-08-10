//
//  Query.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import Foundation

struct VoidVariables: Encodable {}
protocol Query {
	/// The format of the response to expect from the GraphQL request
	associatedtype Variables: Encodable
	associatedtype Response: Decodable

	/**
	 Decode a `Data` object from the GraphQL endpoint into our expected `Response` type.

	 – Parameter data: `Data` – bytes from the network
	 */
	static func decodeResponse(_ data: Data) throws -> Response

	/// The full string to send in the GraphQL request
	var query: String { get }
	var variables: Variables? { get }
	var mockFile: URL { get }
}

extension Query {
	static func decodeResponse(_ data: Data) throws -> Response {
		try JSONDecoder().decode(Response.self, from: data)
	}

	var name: String {
		String(describing: type(of: self)).split(separator: ".").last!.description
	}

	var queryFile: String {
		Bundle.main.path(forResource: name, ofType: "query")!
	}

	var query: String {
		try! String(contentsOfFile: queryFile)
	}

	var variables: Variables? { nil }

	var mockFile: URL {
		Bundle.main.url(forResource: name, withExtension: "mock")!
	}
}
