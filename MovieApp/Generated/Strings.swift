// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Vui lòng nhập Email
  internal static let emailEmty = L10n.tr("Localizable", "email_emty", fallback: "Vui lòng nhập Email")
  /// Email không đúng định dạng
  internal static let emailNotvalid = L10n.tr("Localizable", "email_notvalid", fallback: "Email không đúng định dạng")
  /// Đăng nhập thất bại, Vui lòng kiểm tra lại Email hoặc Mật khẩu
  internal static let loginFailure = L10n.tr("Localizable", "login_failure", fallback: "Đăng nhập thất bại, Vui lòng kiểm tra lại Email hoặc Mật khẩu")
  /// Đăng nhập thành công
  internal static let logInSuccess = L10n.tr("Localizable", "logIn_success", fallback: "Đăng nhập thành công")
  /// Vui lòng nhập Mật khẩu
  internal static let passwordCantEmty = L10n.tr("Localizable", "password_cant_emty", fallback: "Vui lòng nhập Mật khẩu")
  /// Mật khẩu không được có khoảng trắng
  internal static let passwordMustNotContainSpaces = L10n.tr("Localizable", "Password_must_not_contain_spaces", fallback: "Mật khẩu không được có khoảng trắng")
  /// Mật khẩu không đúng định dạng
  internal static let passwordNotvalid = L10n.tr("Localizable", "password_notvalid", fallback: "Mật khẩu không đúng định dạng")
  /// Mật khẩu phải lớn hơn 8 ký tự
  internal static let passwordWeak = L10n.tr("Localizable", "password_weak", fallback: "Mật khẩu phải lớn hơn 8 ký tự")
  /// Localizable.strings
  ///   MovieApp
  /// 
  ///   Created by BeeTech on 09/06/2023.
  internal static let resgiterFailure = L10n.tr("Localizable", "resgiter_failure", fallback: "Đăng ký thất bại!")
  /// Đăng ký thành công
  internal static let resgiterSuccess = L10n.tr("Localizable", "resgiter_success", fallback: "Đăng ký thành công")
  /// Vui lòng nhập tên người dùng
  internal static let userNameEmty = L10n.tr("Localizable", "user_name_emty", fallback: "Vui lòng nhập tên người dùng")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
