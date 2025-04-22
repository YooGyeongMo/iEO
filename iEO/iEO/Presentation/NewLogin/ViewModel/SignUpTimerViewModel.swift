//
//  SignUpAuthViewModel.swift
//  iEO
//
//  Created by Demian Yoo on 4/21/25.
//

// 단일 책임 SRP ViewModel은 시간계산만
// 바인딩
// 테스트 용이성
// SOLID 원칙 중 DIP -> ViewModel은 View을 몰라야하기에, 오직 clousre로만 소통. (느슨한 연결 weak self)

import Foundation

// 단일 책임 클래스 상속 X 니까 final 붙여줌
final class SignUpTimerViewModel{
    //MARK: - Properties
    
    //타이머 시작했을수도 안했을 수도 그래서 옵셔널 타입
    private var timer: Timer?
    
    //private(set) 외부에서는 읽기는 가능하고 해당 뷰모델에서만 객체 접근가능하게.
    private(set) var remainingTime: Int = 300 // 5분
    
    var onTimeChanged: ((String) -> Void)?
    var onTimeExpired: (() -> Void)?
    
    var isRunning: Bool {
        timer != nil
    }
    
    // MARK: - Public Methods
    func start() {
        stop() // 만약 이미 running이 되고 있다면 멈춤.
        remainingTime = 300
        notifyTime() // UI를 즉시 반영해서 update함.
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
        // 1초마다 반복하는 tick함수를 실행하는 타이머를 만든다.
        // weak self 약한참조로 메모리 관리까지 원래 self하면 꽉잡고 안놓아줌.
        // weak self -> self는 옵셔널이됨.
    }
    
    func reset() {
        stop()
        start()
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Private Methods
    private func tick() {
        // remainingTime이 <= 0 이면 중지하고 바로 탈출
        guard remainingTime > 0 else {
            stop()
            onTimeExpired?()
            return
        }
        
        remainingTime -= 1
        notifyTime()
    }
    
    private func notifyTime() {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        // 0을 2자리에 맞춰서 앞에 붙여서 출력
        let formatted = String(format: "%d:%02d", minutes, seconds)
        onTimeChanged?(formatted)
    }
}
