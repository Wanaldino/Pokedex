//
//  HTTPClient.swift
//  Pokedex
//
//  Created by Wanaldino Antimonio on 9/8/22.
//

import Foundation
import Alamofire

public class HTTPClient {
	public init() {}
	struct Response<T: Decodable>: Decodable {
		let data: T
	}
	public func request<T: Query>(query: T) async throws -> T.Response {
		let url = URL(string: "https://beta.pokeapi.co/graphql/v1beta")!

		let body = Body(query: query.query, variables: query.variables)
		let headers = HTTPHeaders(["Content-Type" : "application/json", "X-Method-Used": "graphiql"])

		return try await AF
			.request(url, method: .post, parameters: body, encoder: .json, headers: headers)
			.responseString(completionHandler: { response in
//				print("ℹ️", response)
				let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(UUID().description)

				let object = try! JSONSerialization.jsonObject(with: response.data!, options: [])
				let data = try! JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted])

				try! data.write(to: url!)
				print(url)
			})
			.serializingDecodable(Response<T.Response>.self)
			.value
			.data
	}
}

struct Body<T: Encodable>: Encodable {
	let query: String
	let variables: T?

	enum CodingKeys: CodingKey {
		case query, variables
	}
}
