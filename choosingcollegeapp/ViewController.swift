//
//  ViewController.swift
//  choosingcollegeapp
//
//  Created by Camille Alexander on 5/22/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
// Dispose of any resources that can be recreated.

import UIKit

struct Question {
    var questionString: String?
    var answers: [String]?
    var selectedAnswerIndex: Int?
}

var questionsList: [Question] = [Question(questionString: "What is your favorite campus style?", answers: ["Old", "Modern", "Big", "Small"], selectedAnswerIndex: nil), Question(questionString: "What landscapes do you like?", answers: ["Mountains", "Trees", "Dessert", "City"], selectedAnswerIndex: nil), Question(questionString: "What is your classroom style?", answers: ["Tiny", "Big" , ], selectedAnswerIndex: nil), Question(questionString: "What do you want to get out of college?", answers: ["Meeting new people", "Visiting new places", "Learning new things"], selectedAnswerIndex: nil), Question(questionString: "What is getting away more important than staying home?", answers: ["Yes", "No"], selectedAnswerIndex: nil), Question(questionString: "Is the socail life important to you?", answers: ["Yes", "No"], selectedAnswerIndex: nil), Question(questionString: "Will you spend lot's of time studying?", answers: ["Yes", "No"], selectedAnswerIndex: nil), Question(questionString: "Need a job?", answers: ["Yes", "No"], selectedAnswerIndex: nil), Question(questionString: "Want a place with good food?", answers: ["Yes", "No"], selectedAnswerIndex: nil), Question(questionString: "Want high or low tution cost?", answers: ["High", "Low"], selectedAnswerIndex: nil)]

class QuestionController: UITableViewController {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "Question"
        
        navigationController?.navigationBar.tintColor = UIColor.yellow
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        tableView.register(AnswerCell.self, forCellReuseIdentifier: cellId)
        tableView.register(QuestionHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        tableView.sectionHeaderHeight = 50
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let index = navigationController?.viewControllers.index(of: self) {
            let question = questionsList[index]
            if let count = question.answers?.count {
                return count
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnswerCell
        
        if let index = navigationController?.viewControllers.index(of: self) {
            let question = questionsList[index]
            cell.nameLabel.text = question.answers?[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! QuestionHeader
        
        if let index = navigationController?.viewControllers.index(of: self) {
            let question = questionsList[index]
            header.nameLabel.text = question.questionString
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let index = navigationController?.viewControllers.index(of: self) {
            questionsList[index].selectedAnswerIndex = indexPath.item
            
            if index < questionsList.count - 1 {
                let questionController = QuestionController()
                navigationController?.pushViewController(questionController, animated: true)
            } else {
                let controller = ResultsController()
                navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
}

class ResultsController: UIViewController {
    
    let resultsLabel: UILabel = {
        let label = UILabel()
        label.text = "Congratulations, you will love Baylor!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ResultsController.done))
        
        navigationItem.title = "Results"
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(resultsLabel)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": resultsLabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": resultsLabel]))
        
        let names = ["Baylor University is a private Baptist university in Waco, Texas. Chartered in 1845 by the last Congress of the Republic of Texas, it is the oldest continuously-operating university in Texas and one of the Mississippi River." ,
            
                     "Stanford Stanford University is a private research university in Stanford, California, adjacent to Palo Alto and between San Jose and San Francisco. Its 8,180-acre campus is one of the largest in the United States." ,
            
            "Cal Poly aka California Polytechnic State University or California Polytechnic State University, San Luis Obispo, also known as Cal Poly San Luis Obispo or Cal Poly, is a public university located in San Luis Obispo, California, United States."  ,
            
            
            "Harvard: Harvard University is a private Ivy League research university in Cambridge, Massachusetts, established in 1636, whose history, influence, and wealth have made it one of the world's most prestigious universities.",
            
            "Yale: Yale University is an American private Ivy League research university in New Haven, Connecticut. Founded in 1701, it is the third-oldest institution of higher education in the United States.",
            
            "MIT: The Massachusetts Institute of Technology is a private research university in Cambridge, Massachusetts, often cited as one of the world's most prestigious universities.",
            
            
            "UC San Diego: The University of California, San Diego is a public research university located in the La Jolla neighborhood of San Diego, California, in the United States ",
            
            "University of Virginia: The University of Virginia, frequently referred to simply as Virginia, is a public research university and the flagship for the Commonwealth of Virginia. ",
            
            "University of Washington: The University of Washington, commonly referred to as simply Washington, UW, or informally “U-Dub, ” is a public research university whose largest and original campus is in Seattle, Washington, United States. " ,
            
             "Boston Collage: Boston College is a private Jesuit Catholic research university located in the village of Chestnut Hill, Massachusetts, United States, 6 miles west of downtown Boston. It has 9,100 full-time undergraduates and almost 5,000 graduate students. " ,
            
             "NYU: New York University is a private nonprofit research university based in New York City. Founded in 1831, NYU is considered one of the world's most influential research universities.'"]
     
        //cell.imageView.image = [UIImage imageNamed:@"image.png"];
        var score = 0
        for question in questionsList {
            score += question.selectedAnswerIndex!
        }
        
        let result = names[score % names.count]
        resultsLabel.text = "Congratulations, you will love \(result)!"
    }
    
    func done() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

class QuestionHeader: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Question"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AnswerCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Answer"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
    
}


