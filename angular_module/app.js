angular.module('flapperNews', ['ui.router'])
    .config([
        '$stateProvider',
        '$urlRouterProvider',
        function ($stateProvider, $urlRouterProvider) {
            var helloState = {
                name: 'hello',
                url: '/hello',
                templateUrl: '/hello.html'
            }

            var aboutState = {
                name: 'about',
                url: '/about',
                template: '<h3>Its the UI-Router hello world app!</h3>'
            }

            $stateProvider.state(helloState);
            $stateProvider.state(aboutState);
            $urlRouterProvider.otherwise('home');
        }
    ])
    .factory('posts', [function () {
        var o = {
            posts: [
                {title: 'post 1', upvotes: 5},
                {title: 'post 2', upvotes: 2},
                {title: 'post 3', upvotes: 15},
                {title: 'post 4', upvotes: 9},
                {title: 'post 5', upvotes: 4}
            ]
        }
        return o;
    }])
    .controller('MainCtrl', [
        '$scope',
        'posts',
        function ($scope, posts) {
            $scope.test = 'Hello world!';
            $scope.posts = posts.posts;
            $scope.addPost = function () {
                if (!$scope.title || $scope.title === '') {
                    return;
                }
                $scope.posts.push({title: $scope.title, upvotes: 0, link: $scope.link});
                $scope.title = '';
                $scope.link = '';
            }
            // icrement upvotes
            $scope.incrementUpvote = function (post) {
                post.upvotes++ ;
            }
        }]);