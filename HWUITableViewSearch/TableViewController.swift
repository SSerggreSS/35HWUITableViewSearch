//
//  TableViewController.swift
//  HWUITableViewSearch
//
//  Created by Сергей on 06.03.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//
/*
В этом уроке мы рассмотрели как один массив данных можно преобразовать в другой, более упорядоченный, да еще и с фильтрами. Нужно сделать пару практических упражнений.

✅Ученик.

✅1. Создайте класс студента. У него должны быть свойства: имя, фамилия и год рождения.
✅2. Генерируйте случайное количество студентов и отобразите их в вашей таблице. (слева имя и фамилия, а справа дата рождения)

Студент.

✅3. Сгрупируйте студентов по секциям месяцев рождения, то есть все кто родился в январе в одной секции, а если в феврале никто не родился, то и секции такой нет.
✅4. Внутри секции студенты должны быть отсортированы по имени по алфавиту, а если имена одинаковы, то и по фамилии (подсказка, лучше отсортировать массив вначале по 3 всем параметрам: дата, имя и фамилия)
✅5. Добавьте индекс бар для быстрого перехода по секциям

Мастер.

✅6. Добавьте серчбар как в видео, чтобы кнопочка кенсел анимировано добавлялась/уезжала и тд
✅7. Фильтруйте студентов каждый раз, когда вводится новая буква, причем совпадения ищите как в имени так и в фамилии

Супермен

✅8. Добавьте к серчбару сегментед контрол с тайтлами: Год рождения, Имя, фамилия (по умолчанию включен год рождения)
9. Когда пользователь переключает сегментед контрол, то секции меняются на соответствующие. Например если выбран контрол с именем, то студенты должны быть отсортированы по имя-фамилия-дата, и должны быть собраны в секции, соответствующие первой букве имени.
10. То же самое и для фамилий, фильтр = фамилия-дата-имя
11. если выбрана дата, то все должно отсортироваться как в начале.

желаю успехов :)
 12) добавить возможность удалять студентов
 13) добавить возможность удалять секции
 
*/
 
import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {

    //MARK: Interface Bilder Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //MARK: Properties
    var studentsArray = [Student]()
    var sectionsArray = [Section]()
    var currentOperation: Operation?
    
    //MARK: Life Cycle
    
    override func loadView() {
        super.loadView()
        
        studentsArray = Student.randomStudents(amount: 100)
        
//        sectionsArray = createFilterSectionsWith(students: studentsArray, searchText: searchBar.text)
        self.createSectionsInBackground(from: studentsArray, searchText: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    //MARK: Actions
    
    @IBAction func sortSegmentedControlAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            case 0:
                createSectionsInBackground(from: studentsArray, searchText: searchBar.text)
            case 1:
                createSectionsInBackground(from: studentsArray, searchText: searchBar.text)
            case 2:
                createSectionsInBackground(from: studentsArray, searchText: searchBar.text)
            default:
                break
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsArray.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
        return sectionsArray[section].name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionsArray[section].students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let student = sectionsArray[indexPath.section].students[indexPath.row]
        let textAboutStud = segmentedControl.selectedSegmentIndex != 2 ? "\(student.name) \(student.secondName)" : "\(student.secondName) \(student.name)"
        let textDateOfBirth = DateFormatter.stringFrom(date: student.dateOfBirth, format: "dd.MM.yy")
        cell.detailTextLabel?.text = textDateOfBirth
        cell.textLabel?.text = textAboutStud
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        var titlesSections = [String]()
        
        for section in sectionsArray {
    
            let char = section.name[section.name.startIndex]
            titlesSections.append(String(char))
            
        }
        
        return titlesSections
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            sectionsArray[indexPath.section].students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
        if tableView.numberOfRows(inSection: indexPath.section) == 0 {
            sectionsArray.remove(at: indexPath.section)
            let indexSet = IndexSet(arrayLiteral: indexPath.section)
            tableView.deleteSections(indexSet, with: .fade)
        }
        
    }
    
    //MARK: TableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        TipInCellAnimator.animate(cell: cell)
    }
    
    //MARK: SearchBarDelegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        self.sectionsArray = createFilterSectionsWith(students: studentsArray, searchText: searchText)
//        tableView.reloadData()
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                createSectionsInBackground(from: studentsArray, searchText: searchBar.text)
            case 1:
               sectionsArray = generateSectionsByNameIn(students: studentsArray, searchText: searchBar.text)
               tableView.reloadData()
            case 2:
                sectionsArray = generateSectionsBySecondName(students: studentsArray, searchText: searchBar.text)
                tableView.reloadData()
            default:
            break
        }
        
    }
    
    //MARK: Help Function
    
    private func generateSectionsByMonth(students: [Student], searchText: String?) -> [Section] {
        
         var sortedStudentsArray = students.sorted { (lStud, rStud) -> Bool in
            
            let calendar = Calendar(identifier: .gregorian)
            let monthleftStud = calendar.getComponentMonth(date: lStud.dateOfBirth)
            let monthRightStud = calendar.getComponentMonth(date: rStud.dateOfBirth)
            
            if monthleftStud < monthRightStud {
                return true
            } else {
                return false
            }
            
        }
        
        let searchText = searchText?.lowercased() ?? ""
        
        var section = Section()
        var sectionsArray = [Section]()
        
        let calendar = Calendar(identifier: .gregorian)
        var currentDateMonth = 0
        
        for stud in sortedStudentsArray {
            
            let fullNameForSearch = stud.name.lowercased() + stud.secondName.lowercased()
            
            if searchText.count > 0 && !fullNameForSearch.contains(searchText) {
                continue
            }
            
            let studDateMonth = calendar.getComponentMonth(date: stud.dateOfBirth)
            
            if currentDateMonth != studDateMonth {
                
                currentDateMonth = studDateMonth
                sortedStudentsArray.removeAll()
                sortedStudentsArray.append(stud)
                let monthName = DateFormatter().monthSymbols[currentDateMonth - 1]
                section = Section(name: monthName, students: sortedStudentsArray)
                sectionsArray.append(section)
                
            } else {
                
                section = sectionsArray.last ?? Section()
                sortedStudentsArray.append(stud)
                section.students = sortedStudentsArray
                
            }
        }
    
        return sectionsArray
    }
    
    private func generateSectionsByNameIn(students: [Student], searchText: String?) -> [Section] {

       let sortedStudentsArray = students.sorted { (s1, s2)  -> Bool in
                if s1.name != s2.name {
                    return s1.name < s2.name
                } else if s1.name == s2.name &&
                    s1.secondName != s2.secondName  {
                    return s1.secondName < s2.secondName
                } else {
                    return s1.dateOfBirth < s2.dateOfBirth
                }
            }
        
        let searchText = searchText?.lowercased() ?? ""
            
            var section = Section()
            var studsArray = [Student]()
            var sectionsArray = [Section]()
            
            var currentNameLetter = ""
            
            for stud in sortedStudentsArray {
                
                let fullNameForSearch = stud.name.lowercased() + stud.secondName.lowercased()
                
                if searchText.count > 0 && !fullNameForSearch.contains(searchText) {
                    continue
                }
                
                let firstNameLetter = String(stud.name[stud.name.startIndex])
                
                if currentNameLetter != firstNameLetter {
                    
                    currentNameLetter = firstNameLetter
                    studsArray.removeAll()
                    studsArray.append(stud)
                    section = Section(name: currentNameLetter, students: studsArray)
                    sectionsArray.append(section)
                    
                } else {
                    
                    section = sectionsArray.last ?? Section()
                    studsArray.append(stud)
                    section.students = studsArray
                    
                }
            }
        
            return sectionsArray
    }
    
    private func createSectionsInBackground(from studentsArray: [Student], searchText: String?) {
        
        currentOperation?.cancel()
        currentOperation = BlockOperation(block: {
            var sections = [Section]()
            switch self.segmentedControl.selectedSegmentIndex {
                case 0:
                sections = self.generateSectionsByMonth(students: studentsArray, searchText: searchText)
                case 1:
                    sections = self.generateSectionsByNameIn(students: studentsArray, searchText: self.searchBar.text)
                case 2:
                    sections = self.generateSectionsBySecondName(students: studentsArray, searchText: self.searchBar.text)
                default:
                break
            }
            
            DispatchQueue.main.async {
                self.sectionsArray = sections
                self.tableView.reloadData()
                
                self.currentOperation = nil
            }
        })
        currentOperation?.start()
    }
        
    private func generateSectionsBySecondName(students: [Student], searchText: String?) -> [Section] {
        
        let sortedStudentsArray = students.sorted { (s1, s2)  -> Bool in
                if s1.secondName != s2.secondName {
                    return s1.secondName < s2.secondName
                } else if s1.secondName == s2.secondName &&
                    s1.name != s2.name  {
                    return s1.name < s2.name
                } else {
                    return s1.dateOfBirth < s2.dateOfBirth
                }
            }
        
        let searchText = searchText?.lowercased() ?? ""
            
            var section = Section()
            var studsArray = [Student]()
            var sectionsArray = [Section]()
            
            var currentNameLetter = ""
            
            for stud in sortedStudentsArray {
                
                let fullNameForSearch = stud.name.lowercased() + stud.secondName.lowercased()
                
                if searchText.count > 0 && !fullNameForSearch.contains(searchText) {
                    continue
                }
                
                let firstNameLetter = String(stud.secondName[stud.secondName.startIndex])
                
                if currentNameLetter != firstNameLetter {
                    
                    studsArray.removeAll()
                    studsArray.append(stud)
                    currentNameLetter = firstNameLetter
                    section = Section(name: currentNameLetter, students: studsArray)
                    sectionsArray.append(section)
                    
                } else {
                    
                    section = sectionsArray.last ?? Section()
                    studsArray.append(stud)
                    section.students = studsArray
                    
                }
            }
        
            return sectionsArray
    }
    
}
    
    
    
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


