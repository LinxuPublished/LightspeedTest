//
//  APIClients.swift
//  LightspeedImageList
//
//  Created by Lin Xu on 2022-09-28.
//

import Foundation

public final class APIClient: APIClientProtocol {

    private let session: URLSession
    private let environment: EnvironmentConfiguration

    private var emptyResponseCodes: Set<Int> { return [204, 205] }
    private var acceptableStatusCodes: Range<Int> { return 200..<300 }

    public init(environment: EnvironmentConfiguration) {
        self.environment = environment
        self.session = URLSession(configuration: environment.urlSessionConfiguration)
    }

    public func load<R: APIRequest>(_ request: R, completion: @escaping (Result<R.Response, APIError>) -> Void) {
        send(request, completion: completion)
    }

    /// Construct the URL request from our APIRequest
    func makeURLRequest<T: APIRequest>(from request: T) -> URLRequest? {
        var urlComponents = URLComponents(url: environment.baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = request.path

        guard let requestURL = urlComponents?.url else {
            return nil
        }

        var urlRequest = URLRequest(url: requestURL)
        urlRequest.method = request.method

        if let body = request.body {
            urlRequest.httpBody = body
        }

        if let contentType = request.contentType {
            urlRequest.addHTTPHeader(contentType)
        }

        if let timeout = request.timeoutInterval {
            urlRequest.timeoutInterval = timeout
        }

        return urlRequest
    }
}

private extension APIClient {

    func send<R: APIRequest>(_ request: R, completion: @escaping (Result<R.Response, APIError>) -> Void) {
        guard let urlRequest = makeURLRequest(from: request) else {
            completion(.failure(.invalidRequest))
            return
        }

        session.dataTask(with: urlRequest) { data, urlResponse, error in
            completion(self.parseResponse(data: data, urlResponse: urlResponse, error: error))
        }.resume()
    }

    /// Maps the result of an URLSession dataTask to a Result type
    func parseResponse<D: Decodable>(data: Data?, urlResponse: URLResponse?, error: Error?) -> (Result<D, APIError>) {
        if let error = error {
            return .failure(.requestError(description: error.localizedDescription))
        }

        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            return .failure(.invalidResponse)
        }

        guard acceptableStatusCodes.contains(urlResponse.statusCode) else {
            // Check if we have a valid Passenger API Error returned
            guard let _ = data else {
                return .failure(.unacceptableStatusCode(code: urlResponse.statusCode))
            }
            return .failure(.requestError(description: "Customized Platform error"))
        }

        return decodeData(data: data, urlResponse: urlResponse)
    }

    func decodeData<D: Decodable>(data: Data?, urlResponse: HTTPURLResponse) -> (Result<D, APIError>) {

        guard let data = data, !data.isEmpty else {
            guard emptyResponseCodes.contains(urlResponse.statusCode) else {
                return .failure(.responseDataNilOrZeroLength)
            }

            guard let emptyResponseType = D.self as? EmptyResponse.Type,
                let emptyValue = emptyResponseType.emptyValue() as? D else {
                return .failure(.invalidEmptyResponse(type: "\(D.self)"))
            }

            return .success(emptyValue)
        }

        do {
            let decodedData = try JSONDecoder().decode(D.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(.decodingFailed)
        }
    }
}

public extension URLRequest {

    /// Add a `HTTPHeader` to the header field.
    mutating func addHTTPHeader(_ header: HTTPHeader) {
        addValue(header.value, forHTTPHeaderField: header.field)
    }

    /// Returns the `httpMethod` as the internal `HTTPMethod` enum.
    var method: HTTPMethod? {
        get { return httpMethod.flatMap(HTTPMethod.init) }
        set { httpMethod = newValue?.rawValue }
    }
}
