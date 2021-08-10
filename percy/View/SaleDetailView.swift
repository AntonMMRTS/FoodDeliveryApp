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
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
      
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    
        addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
       
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(saleImage)
        scrollView.addSubview(definitionLabel)

        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 33).isActive = true
        
        saleImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        saleImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        saleImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true
        saleImage.heightAnchor.constraint(equalTo: saleImage.widthAnchor, multiplier: 0.52 ).isActive = true

        definitionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        definitionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        definitionLabel.topAnchor.constraint(equalTo: saleImage.bottomAnchor, constant: 15).isActive = true
        definitionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21).isActive = true
        definitionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
    }
    
}
