import UIKit

class SelectDateView: UIView {
    
    var didChangeTime: (() -> Void)?
    
    var timeIntervalSince1970: TimeInterval {
        get {
            selectDatePicker.date.timeIntervalSince1970
        }
    }
    
    private lazy var selectDateTitleLabel = CustomLabel(
        text: "Selecione a data e hora para reservar",
        size: 28
    )
    
    private lazy var selectDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "pt_BR")
        datePicker.minuteInterval = 1
        datePicker.minimumDate = Date()
        datePicker.date = Calendar.current.date(byAdding: .minute, value: 1, to: Date()) ?? Date()
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .automatic
            }
        }
        
        datePicker.addTarget(self, action: #selector(didChangeDatePickerValue), for: .valueChanged)
        
        return datePicker
    }()
    
    private lazy var durationLabel: CustomLabel = {
        let label = CustomLabel(text: "Duração: 30 minutos")
        label.isHidden = true
        
        return label
    }()
    
    private lazy var estimatedEndTimeLabel: CustomLabel = {
        let label = CustomLabel(text: "Previsão de encerramento: 10:30")
        label.isHidden = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        configureSelectDateTitleLabel()
        configureSelectDatePicker()
        additionalConfiguration()
    }
    
    private func configureSelectDateTitleLabel() {
        addSubview(selectDateTitleLabel)
        
        NSLayoutConstraint.activate([
            selectDateTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22),
            selectDateTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            selectDateTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func configureSelectDatePicker() {
        addSubview(selectDatePicker)
        
        NSLayoutConstraint.activate([
            selectDatePicker.topAnchor.constraint(equalTo: selectDateTitleLabel.bottomAnchor, constant: 32),
            selectDatePicker.leadingAnchor.constraint(equalTo: selectDateTitleLabel.leadingAnchor),
            selectDatePicker.trailingAnchor.constraint(equalTo: selectDateTitleLabel.trailingAnchor)
        ])
    }
    
    private func additionalConfiguration() {
        backgroundColor = .mainBackground
    }
    
    @objc
    private func didChangeDatePickerValue(_ datePicker: UIDatePicker) {
        
        didChangeTime?()
    }
    
    func configureDurationLabels(durationText: String, estimatedEndText: String) {
        
        durationLabel.text = "Duração: \(durationText) minutos"
        durationLabel.isHidden = false
        
        estimatedEndTimeLabel.text = "Previsão de encerramento: \(estimatedEndText)" 
        estimatedEndTimeLabel.isHidden = false
        
        addSubview(durationLabel)
        addSubview(estimatedEndTimeLabel)
        
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(equalTo: selectDatePicker.bottomAnchor, constant: 32),
            durationLabel.leadingAnchor.constraint(equalTo: selectDateTitleLabel.leadingAnchor),
            
            estimatedEndTimeLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 8),
            estimatedEndTimeLabel.leadingAnchor.constraint(equalTo: selectDateTitleLabel.leadingAnchor),
        ])
    }
}
