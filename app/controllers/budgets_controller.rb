class BudgetsController < ApplicationController
  def index
    @budgets = Budget.all
  end

  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    if @budget.save
      redirect_to budgets_path, notice: "Budget was successfully created."
    else
      render :new
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:category, :amount)
  end
end
