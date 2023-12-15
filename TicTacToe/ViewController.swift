/*
 1-)vertical stack view oluşturdum, backgraund=siyah,
    distribution=fill equally(eşit olarak doldur), spacing = 5 olarak ayarladım.
    sağ tık yapıp aspect ratio seçtim. Stack view ekrana ok çektim ve
    yatay ve dikey olarak center, equally widths yaptım
    proportional = 0.9, aspect ratio = 1:1, spacing = 5
    
 2-)horizontal stack view oluşturdum ve vertical stack viewin içine attım
 distribution=fill equally, spacing = 5
    
 3-)button oluşturdum ve horizontal stack view içine attım
    style = default, font = 60, system heavy
 
 4-)buttonları copy paste ile 3 tane yaptım ve 3 dikey sıra elde ettim
    daha sonra horizontal stack viewleri copy paste ile 3 tane yaptım
    ve 3 yatay sıra elde ettim.
 */

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case Nought
        case Cross
        //tur sırasının kimde olduğunu belirlemek için enum tanımladım.
    }
    var firstTurn = Turn.Cross
    //ilk tur cross
    var currentTurn = Turn.Cross
    //şuan ki tur cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = [UIButton]()
    //boş bir dizi oluşturdum
    
    var noughtsScore = 0
    var crosessScore = 0
    //tarafların skorlarını tutmak için değişkenler tanımladım.
    
    @IBOutlet weak var turnLabel: UILabel!
    //Sayfanın üstünde turun kimde olduğunu gösteren labelı tanımladım
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    //bütün butonları tanımladım
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
        //butonları diziye ekledim.
    }

    @IBAction func boardTapAction(_ sender: UIButton) {
        //bir action oluşturup 9 butonuda buna bağladım 9 butondan her hangi birine tıklandığında bu func çalışacak.
        addToBoard(sender)
        
        if checkForVictory(CROSS) {
            crosessScore += 1
            resultAlert(title: "Crosses win")
        }
        if checkForVictory(NOUGHT) {
            noughtsScore += 1
            resultAlert(title: "Noughts win")
        }
        
        if (fullBoard()) {
            resultAlert(title: "Draw")
        }
        
    }
    
    func fullBoard () -> Bool {
    //bu func'ta oyun tahtasın dolu olup olmadığını kontrol ediyorum.
        for button in board{
            if (button.title(for: .normal) == nil) {
            //buttonun başlığı boş mu onu kontrol ediyorum.
                return false
                //eğer boş bir buton başlığı varsa oyun tahtası dolmamıştır.
            }
        }
        return true
        //buton başlıklarını hepsi doluysa oyun tahtası dolmuş demektir.
    }
    
    func resultAlert(title:String) {
        let message = "\nNoughts" + String(noughtsScore) + "\n\nCrosses" + String(crosessScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title:  "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if (firstTurn == Turn.Nought){
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }else if (firstTurn == Turn.Cross){
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
    }
    
    
    func addToBoard(_ sender: UIButton) {
        if (sender.title(for: .normal) == nil) {
        //bu butona daha önce tıklandı mı diye kontrol ediyorum.
            if (currentTurn == Turn.Nought) {
            //şuanda sıra O ise bu if'e girer
                sender.setTitle(NOUGHT, for: .normal)
                //butonun başlığını O yapar
                currentTurn = Turn.Cross
                //sıra X'e geçer
                turnLabel.text = CROSS
            }else if (currentTurn == Turn.Cross) {
            //şuanda sıra X ise bu if'e girer
                sender.setTitle(CROSS, for: .normal)
                //butonun başlığını X yapar
                currentTurn = Turn.Nought
                //sıra O'ya geçer
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
        
    }
    
    func checkForVictory(_ s:String) -> Bool {
        
        if (thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) ){
            return true
        }
        if (thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) ){
            return true
        }
        if (thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) ){
            return true
        }
        
        if (thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) ){
            return true
        }
        if (thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) ){
            return true
        }
        if (thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) ){
            return true
        }
        
        
        if (thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) ){
            return true
        }
        if (thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s) ){
            return true
        }
        
        
        return false
    }
    
    func thisSymbol(_ button:UIButton, _ symbol:String) -> Bool {
        
        return button.title(for: .normal) == symbol
    }
    
}

