//
//  ViewController.swift
//  Rocket
//
//  Created by MacXK on 2025/4/20.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置黄紫相间的渐变背景
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.yellow.cgColor,
            UIColor.purple.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // 添加标题
        let titleLabel = UILabel()
        titleLabel.text = "小火箭节点提取器"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        titleLabel.layer.shadowRadius = 4
        titleLabel.layer.shadowOpacity = 0.7
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // 添加开始提取按钮
        let extractButton = UIButton(type: .system)
        extractButton.setTitle("开始提取", for: .normal)
        extractButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        extractButton.setTitleColor(.white, for: .normal)
        extractButton.backgroundColor = UIColor.systemBlue
        extractButton.layer.cornerRadius = 10
        extractButton.translatesAutoresizingMaskIntoConstraints = false
        extractButton.addTarget(self, action: #selector(handleExtractButton), for: .touchUpInside)
        view.addSubview(extractButton)
        
        NSLayoutConstraint.activate([
            extractButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            extractButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            extractButton.widthAnchor.constraint(equalToConstant: 200),
            extractButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // 添加'提取内容'标题
        let subTitleLabel = UILabel()
        subTitleLabel.text = "提取内容："
        subTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        subTitleLabel.textColor = UIColor.black
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.layer.shadowColor = UIColor.black.cgColor
        subTitleLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        subTitleLabel.layer.shadowRadius = 4
        subTitleLabel.layer.shadowOpacity = 0.7
        view.addSubview(subTitleLabel)
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: extractButton.bottomAnchor, constant: 40),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // 添加显示结果的UILabel
        let contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.textColor = UIColor.white
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentLabel)
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 40),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // 添加版本号标签
        let versionLabel = UILabel()
        versionLabel.text = "版本 1.0"
        versionLabel.font = UIFont.systemFont(ofSize: 14)
        versionLabel.textColor = UIColor.white
        versionLabel.textAlignment = .center
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(versionLabel)
        NSLayoutConstraint.activate([
            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func handleExtractButton() {
        guard let url = URL(string: "https://rocket.xkcc.vip/get_history.php") else {
            print("无效的URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("请求错误: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("没有获取到数据")
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let files = json["files"] as? [[String: Any]],
               let firstFile = files.first,
               let linksArray = firstFile["links"] as? [[String: String]] {
                let links = linksArray.compactMap { $0["url"] }
                
                DispatchQueue.main.async {
                    // 移除所有之前创建的标签和按钮
                    self.view.subviews.forEach { view in
                        if let label = view as? UILabel, (label.tag >= 100 && label.tag < 600) {
                            view.removeFromSuperview()
                        } else if let stack = view as? UIStackView, stack.tag >= 300 {
                            view.removeFromSuperview()
                        }
                    }
                    
                    // 创建新的链接标签
                    var previousLabel: UIView? = nil
                    
                    if !links.isEmpty {
                        let httpTitleLabel = UILabel()
                        httpTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                        httpTitleLabel.textColor = UIColor.black
                        httpTitleLabel.translatesAutoresizingMaskIntoConstraints = false
                        httpTitleLabel.tag = 100
                        self.view.addSubview(httpTitleLabel)
                        NSLayoutConstraint.activate([
                            httpTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                            httpTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
                        ])
                        
                        if let subTitleLabel = self.view.subviews.first(where: { $0 is UILabel && ($0 as! UILabel).text == "提取内容：" }) {
                            httpTitleLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 20).isActive = true
                        }
                        
                        previousLabel = httpTitleLabel
                        
                        for (index, link) in links.enumerated() {
                            let linkLabel = UILabel()
                            linkLabel.numberOfLines = 0
                            linkLabel.text = link
                            linkLabel.textColor = UIColor.black
                            linkLabel.font = UIFont.systemFont(ofSize: 16)
                            linkLabel.translatesAutoresizingMaskIntoConstraints = false
                            linkLabel.tag = 200 + index  // 为每个链接标签设置唯一tag
                            linkLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                            linkLabel.layer.cornerRadius = 5
                            linkLabel.clipsToBounds = true
                            linkLabel.textAlignment = .center
                            self.view.addSubview(linkLabel)
                            
                            NSLayoutConstraint.activate([
                                linkLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                linkLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
                            ])
                            
                            // 添加淡入动画
                            linkLabel.alpha = 0
                            UIView.animate(withDuration: 0.5, delay: Double(index) * 0.1, options: .curveEaseInOut, animations: {
                                linkLabel.alpha = 1
                            })
                            
                            if let prev = previousLabel {
                                linkLabel.topAnchor.constraint(equalTo: prev.bottomAnchor, constant: 20).isActive = true
                            }
                            
                            previousLabel = linkLabel
                            
                            // 添加按钮容器
                            let buttonStack = UIStackView()
                            buttonStack.axis = .horizontal
                            buttonStack.distribution = .fillEqually
                            buttonStack.spacing = 10
                            buttonStack.translatesAutoresizingMaskIntoConstraints = false
                            buttonStack.tag = 300 + index  // 为每个按钮容器设置唯一tag
                            self.view.addSubview(buttonStack)
                            
                            NSLayoutConstraint.activate([
                                buttonStack.topAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: 20),
                                buttonStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                buttonStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                                buttonStack.heightAnchor.constraint(equalToConstant: 40)
                            ])
                            
                            // 添加弹簧动画
                            buttonStack.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                            UIView.animate(withDuration: 0.5, delay: Double(index) * 0.1 + 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                                buttonStack.transform = .identity
                            })
                            
                            // 添加复制按钮
                            let copyButton = UIButton(type: .system)
                            copyButton.setTitle("复制", for: .normal)
                            copyButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                            copyButton.setTitleColor(.white, for: .normal)
                            copyButton.backgroundColor = UIColor.systemGreen
                            copyButton.layer.cornerRadius = 5
                            copyButton.tag = 400 + index  // 为每个复制按钮设置唯一tag
                            copyButton.accessibilityIdentifier = "\(index)"  // 添加标识符
                            copyButton.addTarget(self, action: #selector(self.handleCopyButton(_:)), for: .touchUpInside)
                            buttonStack.addArrangedSubview(copyButton)
                            
                            // 添加小火箭导入按钮
                            let rocketButton = UIButton(type: .system)
                            rocketButton.setTitle("小火箭导入", for: .normal)
                            rocketButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                            rocketButton.setTitleColor(.white, for: .normal)
                            rocketButton.backgroundColor = UIColor.systemOrange
                            rocketButton.layer.cornerRadius = 5
                            rocketButton.tag = 100
                            rocketButton.accessibilityIdentifier = "\(index)"  // 添加标识符
                            rocketButton.addTarget(self, action: #selector(self.handleRocketButton(_:)), for: .touchUpInside)
                            buttonStack.addArrangedSubview(rocketButton)
                            
                            previousLabel = buttonStack as UIView
                            
                            // 添加简介标签
                            let descriptionLabel = UILabel()
                            descriptionLabel.numberOfLines = 0
                            descriptionLabel.text = """
                            1. 点击"复制"按钮可将节点链接复制到剪贴板
                            2. 点击"小火箭导入"可直接导入节点配置
                            3. 节点信息每日自动更新
                            4. 更多应用插件，定制联系VX:Xcode-XK进群
                            """
                            descriptionLabel.font = UIFont.systemFont(ofSize: 14)
                            descriptionLabel.textColor = UIColor.black
                            descriptionLabel.textAlignment = .center
                            descriptionLabel.backgroundColor = UIColor.white.withAlphaComponent(0.7)
                            descriptionLabel.layer.borderColor = UIColor.gray.cgColor
                            descriptionLabel.layer.borderWidth = 1
                            descriptionLabel.layer.cornerRadius = 8
                            descriptionLabel.clipsToBounds = true
                            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
                            descriptionLabel.tag = 500 + index  // 为简介标签设置唯一tag
                            self.view.addSubview(descriptionLabel)
                            
                            NSLayoutConstraint.activate([
                                descriptionLabel.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 30),
                                descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
                                descriptionLabel.heightAnchor.constraint(equalToConstant: 90)
                            ])
                            
                            // 添加淡入动画
                            descriptionLabel.alpha = 0
                            UIView.animate(withDuration: 0.5, delay: Double(index) * 0.1 + 0.4, options: .curveEaseInOut, animations: {
                                descriptionLabel.alpha = 1
                            })
                            
                            previousLabel = descriptionLabel
                        }
                    } else {
                        let noLinksLabel = UILabel()
                        noLinksLabel.text = "没有找到有效的HTTP/HTTPS链接"
                        noLinksLabel.font = UIFont.systemFont(ofSize: 16)
                        noLinksLabel.textColor = UIColor.black
                        noLinksLabel.translatesAutoresizingMaskIntoConstraints = false
                        noLinksLabel.tag = 100
                        self.view.addSubview(noLinksLabel)
                        
                        NSLayoutConstraint.activate([
                            noLinksLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                            noLinksLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
                        ])
                        
                        if let subTitleLabel = self.view.subviews.first(where: { $0 is UILabel && ($0 as! UILabel).text == "提取内容：" }) {
                            noLinksLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 30).isActive = true
                        }
                    }
                    
                    //print("获取到的内容: \(json)")
                }
            }
            
        }
        task.resume()
    }
    
    @objc func handleCopyButton(_ sender: UIButton) {
        guard let indexString = sender.accessibilityIdentifier,
              let index = Int(indexString),
              let linkLabel = self.view.viewWithTag(200 + index) as? UILabel,
              let urlText = linkLabel.text else {
            showCopyError()
            return
        }
        
        UIPasteboard.general.string = urlText
        showCopySuccess()
    }
    
    private func showCopySuccess() {
        let alert = UIAlertController(title: "已复制", message: "链接已复制到剪贴板", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好的", style: .default))
        self.present(alert, animated: true)
    }
    
    private func showCopyError() {
        let alert = UIAlertController(title: "复制失败", message: "无法复制链接", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好的", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc func handleRocketButton(_ sender: UIButton) {
        guard let indexString = sender.accessibilityIdentifier,
              let index = Int(indexString),
              let linkLabel = self.view.viewWithTag(200 + index) as? UILabel,
              let urlString = linkLabel.text,
              let url = URL(string: "shadowrocket://add/" + urlString) else {
            //print("小火箭导入失败: 无效的链接或标识符")
            return
        }
        
//        print("正在处理的小火箭链接: \(urlString)")
//        print("完整导入URL: \(url.absoluteString)")
        UIApplication.shared.open(url)
    }
}

