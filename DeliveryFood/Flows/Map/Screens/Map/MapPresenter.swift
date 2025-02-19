import Foundation

extension Map.Screen.Map {
    final class Presenter {
        weak var viewController: DisplayLogic?
        var router: RoutingLogic?
        
        private let encoderService: EncoderServicable = EncoderService()
        private let decoderService: DecoderServicable = DecoderService()
        private let networkService: Networkable = NetworkService()
    }
}

extension Map.Screen.Map.Presenter: Map.Screen.Map.PresentationLogic {
    func didTapButton1() {
//        do {
//            try networkService.request()
//        } catch {
//            print(error.localizedDescription)
//        }
//        do {
//            let request = AuthLoginRequest(username: "emilys", password: "emilyspass")
//            let bodyData = try encoderService.encode(value: request)
//            let endpoint = AuthEndpoint.login(bodyData)
//            networkService.request(endpoint: endpoint) { result in
//                switch result {
//                case let .success(data):
//                    do {
//                        let response: AuthLoginResponse = try self.decoderService.decode(data: data)
//                        print(response)
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                case let .failure(error):
//                    print(error.localizedDescription)
//                }
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
        Task {
            do {
                let request = AuthLoginRequest(username: "emilys", password: "emilyspass")
                let bodyData = try encoderService.encode(value: request)//кодируем данные для запроса (логин и пароль)
                let endpoint = AuthEndpoint.login(bodyData)//собираем endpoint
                let data = try await networkService.request(endpoint: endpoint)//делаем запрос
                let response: AuthLoginResponse = try self.decoderService.decode(data: data)//декодируем результаты
                await MainActor.run { //на основном потоке показываем результат
                    print(response)
                }
            } catch {
                await MainActor.run { //на главном потоке будет показываться ошибка, кторую можно показать через разные элементы (типа алерт)
                    //update UI
                }
            }
        }
        
    }
    
    func didTapButton2() {
        print(#function)

    }
    
    func didTapButton3() {
        print(#function)

    }
    
    func didTapButton() {
        router?.showCatalogScreen()
    }
}

protocol Networkable {
    func request() throws
    func request(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void)
    func request(endpoint: Endpoint) async throws -> Data
}

final class NetworkService {}

extension NetworkService: Networkable {
    func request() throws {//throws - будет возвращать ошибки, которые можно обработать
        guard let url = URL(string: "https://dummyjson.com/auth/login") else { //URL возвращает опциональное значение, поэтому необходимо развернуть опционал
            throw URLError(.badURL)//если придет nil, то выйдет ошибка "badURL"
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"//httpMethod - описывает метод запроса (GET, POST, DELETE, PUT)
        
        let request = AuthLoginRequest(username: "emilys", password: "emilyspass")
        
        let data = try JSONEncoder().encode(request) //т.к. JSONEncoder throw метод, он запускается через try
        
        urlRequest.httpBody = data //отправляет при запросе на сервер
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type") //Header для запроса
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error {
                print(error.localizedDescription) //тут метод throw не работает, поэтому используем print
            }
            
            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {//urlResponse возвращает код статус код запроса
                print(URLError(.badServerResponse).localizedDescription)
                return
            }
            
            let statusCode = httpURLResponse.statusCode //получаем Int значение
            
            switch statusCode {
            case 200...299:
                if let data {
                    do {
                        let response = try JSONDecoder().decode(AuthLoginResponse.self, from: data)
                        print(response)
                    } catch {
                        print(error.localizedDescription)
                        print("Here")
                    }
                    
                }
            case 401:
                break
            default:
                print(URLError(.badServerResponse))
            }
        }
        .resume() //говорит о том, что запускаем задачу запроса
    }
    
    
    func request(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) { //чтобы вернуть информацию наружу, можно использовать комплишн Result, который является enum Result<Success, Failure> where Failure : Error, Success, где возвращается Data и Error. Т.к. это комплишн, то возвращаем -> Void, @escaping - т.к. запрос будет асинхронным, это гворит о том, что комплишн запустится после окончания асинхронных задач
        
        do {
            let urlRequest = try makeURLRequest(endpoint: endpoint) //если try, то он должен обрабатываться в блоке do{}catch{}
            URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
                if let error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                let statusCode = httpURLResponse.statusCode
                
                switch statusCode {
                case 200...299:
                    if let data  {
                        completion(.success(data))
                    }
                case 401:
                    break //TODO -
                default:
                    completion(.failure(URLError(.badServerResponse)))
                }
            }
            .resume()
        } catch {
            completion(.failure(error))
        }

    }
    
    func request(endpoint: Endpoint) async throws -> Data {//в данном методе функция комплишн будет выполнять await
        let urlRequest = try makeURLRequest(endpoint: endpoint)
        let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)//await - пока не закончится операция, следующая не начнется, замена completion
        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        switch httpURLResponse.statusCode {
        case 200...299:
            return data
//        case 401:
//            break
        default:
            throw URLError(.badServerResponse)
        }
    }
    
    private func makeURLRequest (endpoint: Endpoint) throws -> URLRequest {//метод для сборки URLRequest
        let url = try makeURL(endpoint: endpoint)
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.httpBody = endpoint.body
        
        endpoint.headers.forEach {
            urlRequest.setValue($1, forHTTPHeaderField: $0)
        }
        
        return urlRequest
    }
    
    private func makeURL(endpoint: Endpoint) throws -> URL {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.host
        components.path = endpoint.path
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        print(url.absoluteString)
        return url
    }
}

//https://dummyjson.com/auth/login, где:
protocol Endpoint {
    var scheme: Scheme {get} //https или http - схема
    var host: String {get} //dummyjson.com - хост
    var path: String {get} // auth/login - путь
    var method: Method {get} // - метод запроса (GET, POST, DELETE, PUT)
    var headers: [String: String] {get} // заголовки, хедеры
    var body: Data? {get} // отправные данные
}

enum Scheme: String {
    case http
    case https
}

enum Method: String {
    case get = "GET"
    case post = "POST"
    //case и т.д.
}

enum AuthEndpoint { //описываем запросы
    case login(Data) //будем возвращать данные
    case getUser
    case refresh
}

extension AuthEndpoint: Endpoint { //сборка Endpoint'ов
    var scheme: Scheme {
        switch self {
        case .login, .getUser, .refresh:
            return .https
        }
    }
    
    var host: String {
        switch self {
        case .login, .getUser, .refresh:
            return "dummyjson.com"
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .getUser:
            return "/auth/me"
        case .refresh:
            return "/auth/refresh"
        }
    }
    
    var method: Method {
        switch self {
        case .login, .refresh:
            return .post
        case .getUser:
            return .get
        }
    }
    
    var headers: [String : String] {
        var headers: [String : String] = [:]
        
        switch self {
        case .login, .refresh:
            headers["Content-Type"] = "application/json"
        case .getUser:
            break //обработку авторизации сделаем потом
        }
        return headers
    }
    
    var body: Data? {
        switch self {
        case let .login(data): //возвращаем данные
            return data
        case .getUser, .refresh: //никакие данные тут не возвращаются, поэтому nil
            return nil
        }
    }
}

struct AuthLoginRequest: Encodable {//Encodable - для того, чтобы можно было перевести в формат data (JSON)
    let username: String
    let password: String
}

struct AuthLoginResponse: Decodable {
    let accessToken: String
}

protocol EncoderServicable {//создаем отдельный протокол для кодирования в формат Data с методом
    func encode(value: Encodable) throws -> Data
}

final class EncoderService {}

extension EncoderService: EncoderServicable {
    func encode(value: Encodable) throws -> Data {
        return try JSONEncoder().encode(value)
    }
}

protocol DecoderServicable {//создаем отдельный протокол для декодирования из формата Data с методом в JSON
    func decode <T: Decodable>(data: Data) throws -> T
}

final class DecoderService {}

extension DecoderService: DecoderServicable {
    func decode <T: Decodable>(data: Data) throws -> T {//Т.к. в приложении несколько разных запросов, следовательно по разному нужно распарсить результаты, чтобы унифицировать метод декодирования, функция будет с дженериком, который будет отвечать протоколу Decodable и возвращать метод будет этот же тип Т
        return try JSONDecoder().decode(T.self, from: data)
    }
}
