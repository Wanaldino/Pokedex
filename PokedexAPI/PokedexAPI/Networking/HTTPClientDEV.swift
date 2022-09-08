//
//  HTTPClientDEV.swift
//  PokedexAPI
//
//  Created by Wanaldino Antimonio on 8/9/22.
//

import Foundation

public class HTTPClient {
	public init() {}
	struct Response<T: Decodable>: Decodable {
		let data: T
	}
	public func request<T: Query>(query: T) async throws -> T.Response {
		let data = try! Data(contentsOf: query.mockFile)
		let value = try! JSONDecoder().decode(Response<T.Response>.self, from: data)
		return value.data
	}
}
