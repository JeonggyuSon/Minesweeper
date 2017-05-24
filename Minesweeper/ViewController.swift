//
//  ViewController.swift
//  Minesweeper
//
//  Created by jgson on 2017. 5. 23..
//  Copyright © 2017년 jgson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UITextView!
    
    var randomArray = [Int]() {
        didSet {
            guard let random = randomArray.last else { return }
            
            // 입력한 랜덤한 숫자의 row, colum 값
            let row = random / 10
            let column = random % 10
            
            // 입력한 숫자의 주변 배열 인덱스 값
            let upper = row - 1
            let lower = row + 1
            let left = column - 1
            let right = column + 1
            
            // 주변 배열 인덱스 배열을 순환하며 지뢰의 갯수를 추가
            for i in upper...lower {
                for j in left...right {
                    if (0...9).contains(j) && (0...9).contains(i) && !(i == row && j == column) {
                        let mine = mineArray[i][j]
                        mineArray[i][j] = mine + 1
                    }
                }
            }
        }
    }
    
    // 숫자 0으로 이루어진 2차원 배열 생성
    var mineArray: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 10), count: 10)
    
    // 시작과 끝
    let start : UInt32 = 0
    let end : UInt32 = 99
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 랜덤 숫자 배열에 없는 랜덤한 숫자를 생성 후 배열에 입력
        while randomArray.count < 10 {
            var random = -1
            repeat {
                // 랜덤한 숫자 생성
                random = Int(arc4random_uniform(end - start) + start)
            } while randomArray.contains(random)
            // 배열에 없는 랜덤한 숫자 생성시 추가
            randomArray.append(random)
        }
        
        print("\(randomArray)")
        
        // 지뢰의 갯수를 화면에 출력
        let verticalStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        verticalStack.axis = .vertical
        verticalStack.distribution = .fill
        verticalStack.alignment = .center
        for i in 0..<mineArray.count {
            let stack = UIStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
            stack.axis = .horizontal
            stack.distribution = .fill
            stack.alignment = .center
            for j in 0..<mineArray[i].count {
                let label = UILabel()
                label.textAlignment = .center
                label.heightAnchor.constraint(equalToConstant: 20).isActive = true
                label.widthAnchor.constraint(equalToConstant: 20).isActive = true
                label.text = "\(mineArray[i][j])"
                stack.addArrangedSubview(label)
            }
            verticalStack.addArrangedSubview(stack)
        }
        
        verticalStack.center = view.center
        view.addSubview(verticalStack)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

