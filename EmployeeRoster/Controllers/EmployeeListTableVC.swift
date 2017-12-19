//
//  EmployeeListTableVC.swift
//  EmployeeRoster
//
//  Created by ronny abraham on 12/19/17.
//  Copyright © 2017 ronny abraham. All rights reserved.
//

import UIKit

class EmployeeListTableVC: UITableViewController {

    struct PropertyKeys {
        static let employeeCellIdentifier = "EmployeeCell"
        static let addEmployeeSegueIdentifier = "AddEmployeeSegue"
        static let editEmployeeSegueIdentifier = "EditEmployeeSegue"
    }
    
    var employees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.employeeCellIdentifier, for: indexPath)
        
        let employee = employees[indexPath.row]
        cell.textLabel?.text = employee.name
        cell.detailTextLabel?.text = employee.employeeType.description()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            employees.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let employeeDetail = segue.destination as? EmployeeDetailTableVC else {return}
        
        if let indexPath = tableView.indexPathForSelectedRow,
            segue.identifier == PropertyKeys.editEmployeeSegueIdentifier {
            employeeDetail.employee = employees[indexPath.row]
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        guard let employeeDetail = segue.source as? EmployeeDetailTableVC,
            let employee = employeeDetail.employee else {return}
        
        if let indexPath = tableView.indexPathForSelectedRow {
            employees.remove(at: indexPath.row)
            employees.insert(employee, at: indexPath.row)
        } else {
            employees.append(employee)
        }
    }
}
