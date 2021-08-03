import '../../api/api_base_urls.dart';
import '../../api/identity/identity_api.dart';
import '../../models/identity/reset_password_info.dart';
import '../../models/identity/user_email_info.dart';

class ResetPasswordRepository {
  ResetPasswordRepository();

  IdentityAPI _identityApi = IdentityAPI(
    baseURL: ApiBaseURLS.IDENTITY_BASE_URL,
  );

  Future<void> sendResetPasswordEmail({
    required UserEmailInfo userEmailInfo,
  }) async {
    await _identityApi.post(
      '/ids/profile/resetpassword',
      body: userEmailInfo.toJson(),
    );
  }

  Future<void> resetPassword({
    required ResetPasswordInfo resetPasswordInfo,
  }) async {
    await _identityApi.post(
      '/ids/profile/setpassword',
      body: resetPasswordInfo.toJson(),
    );
  }
}
