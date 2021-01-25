defmodule GrpcSample.Endpoint do
  use GRPC.Endpoint

  intercept(GRPC.Logger.Server)
  run(GrpcSample.User.Server)
end

defmodule GrpcSample.User.Server do
  use GRPC.Server, service: GrpcSample.User.Service

  def create(request, _stream) do
    new_user =
      UserDB.add_user(%{
        first_name: request.first_name,
        last_name: request.last_name,
        age: request.age
      })

    GrpcSample.UserReply.new(new_user)
  end

  def get(request, _stream) do
    user = UserDB.get_user(request.id)

    if user == nil do
      raise GRPC.RPCError, status: :not_found
    else
      GrpcSample.UserReply.new(user)
    end
  end
end
