//
//  main.swift
//  MyCreditManager
//
//  Created by JISUNG LEE on 2023/04/27.
//

import Foundation

struct Item: Codable {
    var name: String?
    var sub: String?
    var grade: String?
}

class ItemManager {
    var items: [Item] = []
    
    func createName(name: String) throws {
        if !items.contains(where: { $0.name == name }) {
            let item = Item(name: name, sub: " ", grade: " ")
            items.append(item)
            print("\(name) 학생을 추가했습니다.")
        } else {
            throw NSError(domain: "ItemManagerErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다."])
        }
    }
    
    func createOrUpdateGrade(name: String, sub: String, grade: String) throws {
        if items.firstIndex(where: { $0.name == name }) != nil {

            let item = Item(name: name, sub: sub, grade: grade)
            items.append(item)
            print("업데이트1\n이름:\(name), 과목:\(sub), 학점:\(grade)")
        } else { print("\(name) 학생이 없습니다.") }
    }
    
    func deleteGrade(name: String, sub: String) throws {
        if let index = items.firstIndex(where: { $0.name == name }) {
            if (items.firstIndex(where: {$0.sub == sub }) != nil) {
                print("\(name) 학생의 \(sub) 과목의 성적이 삭제되었습니다.")
                items[index].grade = nil }
            
            if (items.firstIndex(where:{$0.sub != sub }) != nil) {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }
        }
        else {
 
                throw NSError(domain: "ItemManagerErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "\(name) 학생을 찾지 못했습니다"])
            }
        }
 
    func read(name: String) throws {
        if items.firstIndex(where: { $0.name == name }) != nil {

            for i in items {
                let e = [i]
                if e.contains(where: {$0.name == name}) {
                    print(e)

                } }
        }
        else {
            throw NSError(domain: "ItemManagerErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "\(name) 학생을 찾지 못했습니다."])
            }
        }
    
    func delete(name: String) throws {
        if let index = items.firstIndex(where: { $0.name == name }) {
            print("\(name) 학생을 삭제하였습니다.")
            items.remove(at: index)
        } else {
            throw NSError(domain: "ItemManagerErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "\(name) 학생을 찾지 못했습니다."])
        }
    }
}

let itemManager = ItemManager()

while true {
    print("원하는 기능을 입력해 주세요\n 1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기,  X: 종료")
    
    guard let command = readLine() else { continue }
    
    switch command {
        
    case "1":
        print("추가할 학생의 이름을 입력해주세요")
        guard let name = readLine() else { continue }
        if !name.isEmpty {
            do {
                try itemManager.createName(name: name)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else { print("입력이 잘못되었습니다. 다시 확인해주세요.") }
        
    case "2":
        print("삭제할 학생의 이름을 입력해주세요")
        guard let name = readLine() else { continue }
        do {
            try itemManager.delete(name: name)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    case "3":
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift A+ \n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        guard let input = readLine() else { continue }
        let components = input.split(separator: " ")
        let comCount = components.count
        switch comCount
        {
        case 2:
            do {
                print("comCount 222222")
                try itemManager.createOrUpdateGrade(name: String(components.first!), sub: String(components[1]), grade: " ")
            }
            
        case 3:
            do {
                print("comCount 333333")
                try itemManager.createOrUpdateGrade(name: String(components.first!), sub: String(components[1]), grade: String(components.last!))
            }
        default:
            print("입력이 잘못되었습니다 다시 확인해주세요")
        }
        
    case "4":
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차레로 작성해주세요.")
        //        guard let name = readLine() else { continue }
        guard let input = readLine() else { continue }
        let components = input.split(separator: " ")
        let comCount = components.count
        if comCount == 2 {
            do {
                try itemManager.deleteGrade(name: String(components.first!), sub: String(components[1]))
            }
        } else { print("입력이 잘못되었습니다 다시 확인해주세요!!!!") }
    
    case "5":
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        guard let name = readLine() else { continue }
        if !name.isEmpty {
            do {
                try itemManager.read(name: name)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else { print("입력이 잘못되었습니다. 다시 확인해주세요.")}
        
    case "X":
        print("프로그램을 종료합니다...")
        exit(0)
        
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
}
