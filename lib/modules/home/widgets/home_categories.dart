part of '../home_page.dart';

class _HomeCategories extends StatelessWidget {
  final HomeController _controller;

  const _HomeCategories(this._controller);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 130,
        child: Observer(
          builder: (_) {
            return Center(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _controller.listCategories.length,
                itemBuilder: (_, index) {
                  final category = _controller.listCategories[index];
                  return _CategoryItem(category, _controller);
                },
              ),
            );
          },
        ));
  }
}

class _CategoryItem extends StatelessWidget {
  final SupplierCategoryModel _categoryModel;
  final HomeController _homeController;
  static const categoriesIcons = {
    'P': Icons.pets,
    'V': Icons.local_hospital,
    'C': Icons.store_mall_directory,
  };
  const _CategoryItem(
    this._categoryModel,
    this._homeController,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _homeController.filterSupplierCategory(_categoryModel),
      child: Container(
          margin: const EdgeInsets.all(20),
          child: Observer(
            builder: (_) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor:
                        _homeController.supplierCategoryFilterSelected?.id == _categoryModel.id
                            ? context.primaryColor
                            : context.primaryColorLight,
                    radius: 30,
                    child: Icon(
                      categoriesIcons[_categoryModel.type],
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _categoryModel.name,
                    style: TextStyle(
                      fontWeight:
                          _homeController.supplierCategoryFilterSelected?.id == _categoryModel.id
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
