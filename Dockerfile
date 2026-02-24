# Use official .NET SDK image for build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy csproj from project folder
COPY WebApplication1/WebApplication1.csproj WebApplication1/

# Restore
RUN dotnet restore WebApplication1/WebApplication1.csproj

# Copy everything else
COPY . .

# Move into project folder
WORKDIR /src/WebApplication1

# Publish
RUN dotnet publish -c Release -o /app/out

# Use official runtime image
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app/out .

EXPOSE 80

ENTRYPOINT ["dotnet", "WebApplication1.dll"]

