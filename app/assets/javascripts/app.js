var app = angular.module('mainApp', []);
app.config( ["$httpProvider", function($httpProvider){
$httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')}
    ]);
app.service('companies', ['$http', companiesService]);
app.controller('HomeCtrl', ['$scope', 'companies', homeController]);
function homeController($scope, companies){
    $scope.status;
    $scope.companies;
    $scope.page = 1;
    getCompanies($scope.page);
    function getCompanies(page) {
        debugger
        companies.getCompaniesByPage(page)
            .then(function (response) {
                $scope.companies = response.data;
                console.log(response)
            }, function (error) {
                $scope.status = 'Unable to load companies data' + error;
                console.log(error);
            })
    }
    $scope.showMore = function () {
        $scope.page++;
        companies.getCompaniesByPage($scope.page)
            .then(function (response) {
                debugger
                $scope.companies = $scope.companies.concat(response.data);
            }, function (error) {
                $scope.status = 'No more' + error;
            })
    }
    $scope.deleteCompany= function(index){

        if (confirm("sure to delete")) {
            debugger
            companies.deleteCompany($scope.companies[index].id)
                .then(function () {
                    // getCompanies($scope.page)
                    $scope.companies.splice(index, 1);
                }, function (error) {
                    console.log(error);
                })
        }
    }
}
function companiesService($http){
    var urlBase = '/companies'
    this.getCompanies = function () {
        return $http.get(urlBase,{
            params: {page: $scope.page}
        });
    };
    this.getCompaniesByPage = function (page) {
        return $http.get(urlBase,{
            params: {page: page}
        });
    };

    this.getCompany = function (id) {
        return $http.get(urlBase + '/' + id);
    };

    this.insertCompany = function (cust) {
        return $http.post(urlBase, cust);
    };

    this.updateCompany = function (cust) {
        return $http.put(urlBase + '/' + cust.ID, cust)
    };

    this.deleteCompany = function (id) {
        debugger
        return $http.delete(urlBase + '/' + id +'.json');
    };

    this.getOrders = function (id) {
        return $http.get(urlBase + '/' + id + '/orders');
    };
}