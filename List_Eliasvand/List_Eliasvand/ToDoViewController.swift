//
//  ToDoViewController.swift
//  List_Eliasvand
//
//  Created by Faniz Eliasvand on 11/19/21.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
              navigationItem.title = "To-Do"
              titleTextField.text = todo.title
              isCompleteButton.isSelected = todo.isComplete
              dueDatePickerView.date = todo.dueDate
              notesTextView.text = todo.notes
            } else {
              dueDatePickerView.date =
              Date().addingTimeInterval(24*60*60)
            }
        

        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
        
    }
    var todo : ToDo?
    var isPickerHidden = true
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    func updateSaveButtonState() {
        let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }
    
    
    
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
    
    
        
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesTextViewIndexPath = IndexPath(row: 0, section: 2)
    let normalCellHeight = CGFloat(44)
    let largeCellHeight = CGFloat(200)
    let pickerHeightOpen = CGFloat(165)
    let pickerHeightClosed = CGFloat(0)
   
    override func tableView(_ tableView: UITableView, heightForRowAt
    indexPath: IndexPath) -> CGFloat {
       

        switch(indexPath) {
        case datePickerIndexPath:
            if(isPickerHidden) {
                dueDatePickerView.isHidden = true
                return normalCellHeight
            } else {
                dueDatePickerView.isHidden = false
                return pickerHeightOpen
            }

        case notesTextViewIndexPath:
            return largeCellHeight

        default: return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt
    indexPath: IndexPath) {
        switch (datePickerIndexPath) {
        case datePickerIndexPath:
            
            isPickerHidden = !isPickerHidden
    
            dueDateLabel.textColor =
            isPickerHidden ? .black : tableView.tintColor
    
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default: break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
    Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
    
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate:
        dueDate, notes: notes)
        
    }
    

   
   

   
    
  
    
    
    
    
    

}
   
    

    
    
    


