//
//  EmployeeTableVC.swift
//  EmployeeRoster
//
//  Created by ronny abraham on 12/19/17.
//  Copyright © 2017 ronny abraham. All rights reserved.
//

import UIKit

class EmployeeDetailTableVC: UITableViewController, UITextFieldDelegate, EmployeeTypeDelegate {
    
    
    func didSelectType(employeeType: EmployeeType) {
        self.employeeType = employeeType
        updateType()
    }
    
    
    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue"
    }
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var employeeTypeLabel: UILabel!
    
    var employee: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateView()
        updateType()
//        updateDateViews()
        
    }
    
    
    func updateView() {
        if let employee = employee
        {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            nameTextField.font = nameTextField.font?.withSize(25)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            dobLabel.text = dateFormatter.string(from: employee.dateOfBirth)
            dobLabel.textColor = .black
            dobLabel.font = dobLabel.font.withSize(25)
            employeeTypeLabel.text = employee.employeeType.description()
            employeeTypeLabel.textColor = .black
            employeeTypeLabel.font = employeeTypeLabel.font.withSize(25)
            
            employeeType = employee.employeeType
            
        } else {
            
            navigationItem.title = "New Employee"
        }
    }
    
    var employeeType: EmployeeType?
    
    func updateType() {
        if let type = employeeType {
            
            employeeTypeLabel.text = type.description()
        } else {
            employeeTypeLabel.text = "Not Set"
        }
    }
   

////    func updateDateViews() {
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateStyle = .medium
//
//        dobLabel.text = dateFormatter.string(from: datePicker.date)
//    }
    
    
    let datePickerIndexPath = IndexPath(row: 2, section: 0)
    
    var isEditingBirthday: Bool = false {
        didSet {
            datePicker.isHidden = !isEditingBirthday
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch(indexPath.section, indexPath.row) {
            
        case (datePickerIndexPath.section, datePickerIndexPath.row):
            if isEditingBirthday {
                return 172.0
            } else {
                return 0
            }
       
            
        default:
            return 44.0
        }
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
            
            
        case (datePickerIndexPath.section, datePickerIndexPath.row - 1):
            if isEditingBirthday {
                isEditingBirthday = false
            } else if isEditingBirthday {
                isEditingBirthday = false
                isEditingBirthday = true
            }
            else {
                isEditingBirthday = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
    
        default:
            break

        }
    }
    
    
    @IBAction func datePickerValueChanged()
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        
        dobLabel.text = dateFormatter.string(from: datePicker.date)
        
    }
   
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let name = nameTextField.text {
            employee = Employee(name: name, dateOfBirth: datePicker.date, employeeType: employeeType!)
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
        }
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        employee = nil
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }
    
    // MARK: - Text Field Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
 
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectEmployeeType" {
            let destinationViewController = segue.destination as? EmployeeTypeTableViewController
            
            destinationViewController?.delegate = self as? EmployeeTypeDelegate
            destinationViewController?.employeeType = employeeType
        }
        
        
    }
    
}


