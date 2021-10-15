import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    let categoryFoodLabel: UILabel = {
        let categoryFoodLabel = UILabel()
        categoryFoodLabel.textColor = .white
        categoryFoodLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 23)
        categoryFoodLabel.textAlignment = .center
        categoryFoodLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoryFoodLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryFoodLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        autolayoutSetup()
    }
    
    func setupCell(category: String) {
        categoryFoodLabel.text = category
    }
    
    private func autolayoutSetup() {
        NSLayoutConstraint.activate([
            categoryFoodLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            categoryFoodLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            categoryFoodLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            categoryFoodLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
}
