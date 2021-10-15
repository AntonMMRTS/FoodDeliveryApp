import UIKit

class SaleDetailView: UIView {

    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var saleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var definitionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.textColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var scrollView: UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        autolayoutSetup()
    }
    
    private func autolayoutSetup() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 33),
            
            saleImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            saleImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            saleImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            saleImage.heightAnchor.constraint(equalTo: saleImage.widthAnchor, multiplier: 0.52 ),
            
            definitionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            definitionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            definitionLabel.topAnchor.constraint(equalTo: saleImage.bottomAnchor, constant: 15),
            definitionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21),
            definitionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50)
        ])
    }
    
    private func setupView() {
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(saleImage)
        scrollView.addSubview(definitionLabel)
    }
    
}
